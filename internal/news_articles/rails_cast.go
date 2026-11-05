package newsarticles

// This file reproduces how ActiveRecord (Rails 6.1, Ruby 2.7) turned a param
// value into a news_articles column value, so Go stores what Rails stored:
// strings use Ruby's to_s/inspect, priority uses Ruby's to_i, and datetimes use
// ActiveSupport's Time.zone.parse with Time.zone = UTC.

import (
	"encoding/json"
	"errors"
	"fmt"
	"math"
	"math/big"
	"strconv"
	"strings"
	"unicode"
)

// errIntegerOutOfRange is ActiveModel::RangeError: a priority outside the
// 4-byte integer column, which made the Rails save fail with a 500.
var errIntegerOutOfRange = errors.New("integer out of range for a 4-byte integer column")

// castString mirrors ActiveModel::Type::String#cast.
func castString(value any) *string {
	var s string
	switch v := value.(type) {
	case nil:
		return nil
	case string:
		s = v
	case bool:
		s = "f"
		if v {
			s = "t"
		}
	case json.Number:
		s = rubyNumberToS(v)
	default:
		s = rubyInspect(v)
	}
	return &s
}

// castInteger mirrors ActiveModel::Type::Integer#cast plus the range check
// Rails ran when saving.
func castInteger(value any) (*int64, error) {
	var n *big.Int
	switch v := value.(type) {
	case bool:
		n = big.NewInt(0)
		if v {
			n = big.NewInt(1)
		}
	case string:
		if isRubyBlank(v) {
			return nil, nil
		}
		n = rubyStringToI(v)
	case json.Number:
		if isIntegerLiteral(v) {
			n, _ = new(big.Int).SetString(v.String(), 10)
			break
		}
		f, _ := strconv.ParseFloat(v.String(), 64)
		if math.IsInf(f, 0) {
			// Infinity.to_i raised FloatDomainError, which the cast rescued to nil.
			return nil, nil
		}
		n, _ = big.NewFloat(f).Int(nil)
	default:
		// nil, arrays and hashes have no to_i, which the cast rescued to nil.
		return nil, nil
	}
	if !n.IsInt64() || n.Int64() < math.MinInt32 || n.Int64() > math.MaxInt32 {
		return nil, errIntegerOutOfRange
	}
	i := n.Int64()
	return &i, nil
}

// isRubyPresent mirrors Object#present?, which decided whether `active` was set.
func isRubyPresent(value any) bool {
	switch v := value.(type) {
	case nil:
		return false
	case bool:
		return v
	case string:
		return !isRubyBlank(v)
	case []any:
		return len(v) > 0
	case *paramHash:
		return len(v.keys) > 0
	}
	return true
}

func isRubyBlank(s string) bool {
	return strings.TrimFunc(s, unicode.IsSpace) == ""
}

func isIntegerLiteral(n json.Number) bool {
	return !strings.ContainsAny(n.String(), ".eE")
}

// rubyNumberToS formats a JSON number the way Ruby printed the Integer or Float
// that its JSON parser produced.
func rubyNumberToS(n json.Number) string {
	if isIntegerLiteral(n) {
		i, _ := new(big.Int).SetString(n.String(), 10)
		return i.String()
	}
	f, _ := strconv.ParseFloat(n.String(), 64)
	return rubyFloatToS(f)
}

// rubyFloatToS ports Ruby's Float#to_s: the shortest round-trip digits, in
// fixed notation when the decimal exponent is in (-4, 15] and in Ruby's
// "1.0e+20" exponent form otherwise.
func rubyFloatToS(f float64) string {
	switch {
	case math.IsInf(f, 1):
		return "Infinity"
	case math.IsInf(f, -1):
		return "-Infinity"
	case math.IsNaN(f):
		return "NaN"
	case f == 0 && math.Signbit(f):
		return "-0.0"
	case f == 0:
		return "0.0"
	}
	sign := ""
	if f < 0 {
		sign, f = "-", -f
	}
	mantissa, exponent, _ := strings.Cut(strconv.FormatFloat(f, 'e', -1, 64), "e")
	digits := strings.Replace(mantissa, ".", "", 1)
	exp, _ := strconv.Atoi(exponent)
	decimalPoint := exp + 1

	switch {
	case decimalPoint > 0 && decimalPoint <= 15:
		if len(digits) <= decimalPoint {
			return sign + digits + strings.Repeat("0", decimalPoint-len(digits)) + ".0"
		}
		return sign + digits[:decimalPoint] + "." + digits[decimalPoint:]
	case decimalPoint <= 0 && decimalPoint > -4:
		return sign + "0." + strings.Repeat("0", -decimalPoint) + digits
	}
	fraction := digits[1:]
	if fraction == "" {
		fraction = "0"
	}
	return fmt.Sprintf("%s%s.%se%+03d", sign, digits[:1], fraction, decimalPoint-1)
}

// rubyStringToI ports String#to_i: leading whitespace, an optional sign, an
// optional "0d" prefix, then digits that may be separated by single underscores.
// Anything else ends the number, and no digits at all gives 0.
func rubyStringToI(s string) *big.Int {
	i := 0
	for i < len(s) && strings.IndexByte(" \t\n\v\f\r", s[i]) >= 0 {
		i++
	}
	negative := false
	if i < len(s) && (s[i] == '+' || s[i] == '-') {
		negative = s[i] == '-'
		i++
	}
	if i+1 < len(s) && s[i] == '0' && (s[i+1] == 'd' || s[i+1] == 'D') {
		i += 2
	}
	var digits strings.Builder
	for i < len(s) {
		c := s[i]
		if c >= '0' && c <= '9' {
			digits.WriteByte(c)
		} else if !(c == '_' && digits.Len() > 0 && i+1 < len(s) && s[i+1] >= '0' && s[i+1] <= '9') {
			break
		}
		i++
	}
	n := new(big.Int)
	if digits.Len() > 0 {
		n.SetString(digits.String(), 10)
	}
	if negative {
		n.Neg(n)
	}
	return n
}

// rubyInspect ports #inspect for the values params can hold, which is what
// Rails stored when an array or hash reached a string column.
func rubyInspect(value any) string {
	switch v := value.(type) {
	case nil:
		return "nil"
	case bool:
		return strconv.FormatBool(v)
	case string:
		return rubyStringInspect(v)
	case json.Number:
		return rubyNumberToS(v)
	case []any:
		items := make([]string, len(v))
		for i, item := range v {
			items[i] = rubyInspect(item)
		}
		return "[" + strings.Join(items, ", ") + "]"
	case *paramHash:
		pairs := make([]string, len(v.keys))
		for i, key := range v.keys {
			pairs[i] = rubyStringInspect(key) + "=>" + rubyInspect(v.get(key))
		}
		return "{" + strings.Join(pairs, ", ") + "}"
	}
	return fmt.Sprint(value)
}

var rubyShortEscapes = map[rune]string{
	'"': `\"`, '\\': `\\`, '\n': `\n`, '\r': `\r`, '\t': `\t`, '\f': `\f`, '\v': `\v`, '\b': `\b`, '\a': `\a`, 0x1b: `\e`,
}

// rubyStringInspect ports String#inspect for UTF-8 strings.
func rubyStringInspect(s string) string {
	runes := []rune(s)
	var b strings.Builder
	b.WriteByte('"')
	for i, r := range runes {
		if escape, ok := rubyShortEscapes[r]; ok {
			b.WriteString(escape)
			continue
		}
		switch {
		case r == '#' && i+1 < len(runes) && strings.ContainsRune("{$@", runes[i+1]):
			b.WriteString(`\#`)
		case isRubyPrintable(r):
			b.WriteRune(r)
		case r < 0x10000:
			fmt.Fprintf(&b, `\u%04X`, r)
		default:
			fmt.Fprintf(&b, `\u{%X}`, r)
		}
	}
	b.WriteByte('"')
	return b.String()
}

// isRubyPrintable is Onigmo's [[:print:]] for Unicode: everything except
// control characters, surrogates, unassigned code points, and whitespace other
// than space separators.
func isRubyPrintable(r rune) bool {
	if unicode.In(r, unicode.Cc, unicode.Cs) {
		return false
	}
	if unicode.IsSpace(r) && !unicode.Is(unicode.Zs, r) {
		return false
	}
	return unicode.In(r, unicode.L, unicode.M, unicode.N, unicode.P, unicode.S, unicode.Z, unicode.Cf, unicode.Co)
}
