package newsarticles

// Rails stored effective_date and expiration_date by calling
// ActiveSupport::TimeZone#parse (Time.zone is UTC), which uses Ruby's
// Date._parse. This file ports the parts of Date._parse that apply to dates
// people send: weekday names, times with am/pm and zones, "15 Aug 2026",
// "Aug 15, 2026", "2026-08-15", "15-Aug-2026", "2026/08/15", "2026.08.15", and a
// bare month name or "15th". Ruby's remaining parsers (Japanese era dates,
// ISO week and ordinal dates, bare digit runs like "20260815", BC years) are
// not ported, so those strings are stored as nil here.

import (
	"regexp"
	"strconv"
	"strings"
	"time"
)

// railsMaxDateLength is the input limit Ruby's date library added for
// CVE-2021-41817; longer strings raised ArgumentError, which the cast rescued to nil.
const railsMaxDateLength = 128

const monthAlternation = `jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec`
const eraAlternation = `c(?:e|\.e\.)|b(?:ce|\.c\.e\.)|a(?:d|\.d\.)|b(?:c|\.c\.)`

var (
	dateSeparatorPattern = regexp.MustCompile(`[^-+',./:@0-9A-Za-z\[\]]+`)
	dayNamePattern       = regexp.MustCompile(`(?i)\b(sun|mon|tue|wed|thu|fri|sat)[^-/\d\s]*`)
	timePattern          = regexp.MustCompile(`(?i)(` +
		`(?:\d+\s*:\s*\d+(?:\s*:\s*\d+(?:[,.]\d*)?)?|\d+\s*h(?:\s*\d+m?(?:\s*\d+s?)?)?)(?:\s*[ap](?:m\b|\.m\.))?` +
		`|\d+\s*[ap](?:m\b|\.m\.))` +
		`(?:\s*((?:gmt|utc?)?[-+]\d+(?:[,.:]\d+(?::\d+)?)?` +
		`|(?-i:[[:alpha:].\s]+)(?:standard|daylight)\stime\b` +
		`|(?-i:[[:alpha:]]+)(?:\sdst)?\b))?`)
	timePartsPattern = regexp.MustCompile(`(?i)^(\d+)h?(?:\s*:?\s*(\d+)m?(?:\s*:?\s*(\d+)(?:[,.](\d+))?s?)?)?(?:\s*([ap])(?:m\b|\.m\.))?`)
	euDatePattern    = regexp.MustCompile(`(?i)'?\b(\d+)[^-\d\s']*\s*(` + monthAlternation + `)[^-\d\s']*(?:\s*(` + eraAlternation + `)?\s*('?-?\d+(?:(?:st|nd|rd|th)\b)?))?`)
	usDatePattern    = regexp.MustCompile(`(?i)\b(` + monthAlternation + `)[^-\d\s']*\s*('?\d+)[^-\d\s']*(?:\s*,?\s*(` + eraAlternation + `)?\s*('?-?\d+))?`)
	isoDatePattern   = regexp.MustCompile(`('?[-+]?\d+)-(\d+)-('?-?\d+)`)
	vmsDatePattern   = regexp.MustCompile(`(?i)('?-?\d+)-(` + monthAlternation + `)[^-/.]*-('?-?\d+)`)
	slashDatePattern = regexp.MustCompile(`('?-?\d+)/\s*('?\d+)(?:\D\s*('?-?\d+))?`)
	dotDatePattern   = regexp.MustCompile(`('?-?\d+)\.\s*('?\d+)\.\s*('?-?\d+)`)
	monthOnlyPattern = regexp.MustCompile(`(?i)\b(` + monthAlternation + `)\S*`)
	mdayOnlyPattern  = regexp.MustCompile(`(?i)(\d+)(st|nd|rd|th)\b`)
)

// dateParts is the hash Date._parse returned. A nil field was absent.
type dateParts struct {
	year, mon, mday, hour, min, sec *int
	nanos                           int
	offsetSeconds                   *int
	found                           bool // the hash was not empty
}

// castDateTime mirrors the time-zone-aware datetime cast. Non-strings and
// strings Rails could not parse become nil.
func castDateTime(value any, now time.Time) *time.Time {
	s, ok := value.(string)
	if !ok || len(s) > railsMaxDateLength {
		return nil
	}
	parts := parseRubyDate(s)
	if !parts.found {
		return nil
	}
	return partsToTime(parts, now.UTC())
}

func parseRubyDate(input string) dateParts {
	var parts dateParts
	str := dateSeparatorPattern.ReplaceAllString(input, " ")

	if match := firstMatch(&str, dayNamePattern); match != nil {
		parts.found = true // Ruby records the weekday, which Time.new ignores
	}
	if match := firstMatch(&str, timePattern); match != nil {
		parts.found = true
		parseTimeOfDay(match[1], &parts)
		if match[2] != "" {
			parts.offsetSeconds = zoneOffsetSeconds(match[2])
		}
	}

	dateParsers := []func(*string, *dateParts) bool{
		parseEuDate, parseUsDate, parseIsoDate, parseVmsDate, parseSlashDate, parseDotDate, parseMonthOnly, parseMdayOnly,
	}
	for _, parse := range dateParsers {
		if parse(&str, &parts) {
			parts.found = true
			break
		}
	}
	return parts
}

// firstMatch finds the first match of pattern in *str and replaces it with a
// single space, like Ruby's subx, so later parsers do not see it again.
func firstMatch(str *string, pattern *regexp.Regexp) []string {
	loc := pattern.FindStringSubmatchIndex(*str)
	if loc == nil {
		return nil
	}
	groups := make([]string, len(loc)/2)
	for i := range groups {
		if loc[2*i] >= 0 {
			groups[i] = (*str)[loc[2*i]:loc[2*i+1]]
		}
	}
	*str = (*str)[:loc[0]] + " " + (*str)[loc[1]:]
	return groups
}

func parseTimeOfDay(text string, parts *dateParts) {
	m := timePartsPattern.FindStringSubmatch(text)
	if m == nil {
		return
	}
	hour, _ := strconv.Atoi(m[1])
	if m[5] != "" {
		hour %= 12
		if strings.EqualFold(m[5], "p") {
			hour += 12
		}
	}
	parts.hour = &hour
	if m[2] != "" {
		minute, _ := strconv.Atoi(m[2])
		parts.min = &minute
	}
	if m[3] != "" {
		second, _ := strconv.Atoi(m[3])
		parts.sec = &second
	}
	if m[4] != "" {
		fraction := (m[4] + "000000000")[:9]
		parts.nanos, _ = strconv.Atoi(fraction)
	}
}

func monthNumber(name string) string {
	index := strings.Index(monthAlternation, strings.ToLower(name[:3]))
	return strconv.Itoa(index/4 + 1)
}

func parseEuDate(str *string, parts *dateParts) bool {
	m := firstMatch(str, euDatePattern)
	if m == nil {
		return false
	}
	s3e(parts, optional(m[4]), optional(monthNumber(m[2])), optional(m[1]), m[3] != "" && strings.HasPrefix(strings.ToLower(m[3]), "b"))
	return true
}

func parseUsDate(str *string, parts *dateParts) bool {
	m := firstMatch(str, usDatePattern)
	if m == nil {
		return false
	}
	s3e(parts, optional(m[4]), optional(monthNumber(m[1])), optional(m[2]), m[3] != "" && strings.HasPrefix(strings.ToLower(m[3]), "b"))
	return true
}

func parseIsoDate(str *string, parts *dateParts) bool {
	m := firstMatch(str, isoDatePattern)
	if m == nil {
		return false
	}
	s3e(parts, optional(m[1]), optional(m[2]), optional(m[3]), false)
	return true
}

func parseVmsDate(str *string, parts *dateParts) bool {
	m := firstMatch(str, vmsDatePattern)
	if m == nil {
		return false
	}
	s3e(parts, optional(m[3]), optional(monthNumber(m[2])), optional(m[1]), false)
	return true
}

func parseSlashDate(str *string, parts *dateParts) bool {
	m := firstMatch(str, slashDatePattern)
	if m == nil {
		return false
	}
	s3e(parts, optional(m[1]), optional(m[2]), optional(m[3]), false)
	return true
}

func parseDotDate(str *string, parts *dateParts) bool {
	m := firstMatch(str, dotDatePattern)
	if m == nil {
		return false
	}
	s3e(parts, optional(m[1]), optional(m[2]), optional(m[3]), false)
	return true
}

func parseMonthOnly(str *string, parts *dateParts) bool {
	m := firstMatch(str, monthOnlyPattern)
	if m == nil {
		return false
	}
	month, _ := strconv.Atoi(monthNumber(m[1]))
	parts.mon = &month
	return true
}

func parseMdayOnly(str *string, parts *dateParts) bool {
	m := firstMatch(str, mdayOnlyPattern)
	if m == nil {
		return false
	}
	day, _ := strconv.Atoi(m[1])
	parts.mday = &day
	return true
}

func optional(s string) *string {
	if s == "" {
		return nil
	}
	return &s
}

// s3e ports Date._parse's s3e, which decides which of three numbers is the
// year, month and day (for example "15-08-2026" is read as 2026-08-15).
func s3e(parts *dateParts, y, m, d *string, bc bool) {
	if y != nil && m != nil && d == nil {
		y, m, d = nil, y, m
	}
	if y == nil && d != nil && (len(*d) > 2 || strings.HasPrefix(*d, "'")) {
		y, d = d, nil
	}
	if y != nil {
		s := *y
		start := strings.IndexAny(s, "+-0123456789")
		if start < 0 {
			start = len(s)
		}
		rest := s[start:]
		digitsStart := 0
		if rest != "" && (rest[0] == '+' || rest[0] == '-') {
			digitsStart = 1
		}
		if digitsStart+leadingDigits(rest[digitsStart:]) < len(rest) {
			y, d = d, &rest
		}
	}
	if m != nil && (strings.HasPrefix(*m, "'") || len(*m) > 2) {
		y, m, d = m, d, y
	}
	if d != nil && (strings.HasPrefix(*d, "'") || len(*d) > 2) {
		y, d = d, y
	}

	if y != nil {
		s := *y
		start := strings.IndexAny(s, "+-0123456789")
		if start >= 0 {
			s = s[start:]
			negative := strings.HasPrefix(s, "-")
			s = strings.TrimLeft(s, "+-")
			year, _ := strconv.Atoi(s[:leadingDigits(s)])
			if negative {
				year = -year
			}
			if bc {
				year = -year + 1
			}
			parts.year = &year
		}
	}
	if m != nil {
		if month, ok := firstNumber(*m); ok {
			parts.mon = &month
		}
	}
	if d != nil {
		if day, ok := firstNumber(*d); ok {
			parts.mday = &day
		}
	}
}

func leadingDigits(s string) int {
	n := 0
	for n < len(s) && s[n] >= '0' && s[n] <= '9' {
		n++
	}
	return n
}

func firstNumber(s string) (int, bool) {
	start := strings.IndexAny(s, "0123456789")
	if start < 0 {
		return 0, false
	}
	n, err := strconv.Atoi(s[start : start+leadingDigits(s[start:])])
	return n, err == nil
}

// partsToTime ports ActiveSupport::TimeZone#parts_to_time and the range checks
// of Ruby's Time.new; out-of-range parts raised ArgumentError, which the cast
// rescued to nil. Missing parts default from now, and a time without a zone is
// read as UTC.
func partsToTime(parts dateParts, now time.Time) *time.Time {
	year, mon := now.Year(), int(now.Month())
	if parts.year != nil {
		year = *parts.year
	}
	if parts.mon != nil {
		mon = *parts.mon
	}
	mday := now.Day()
	if parts.year != nil || parts.mon != nil {
		mday = 1
	}
	if parts.mday != nil {
		mday = *parts.mday
	}
	hour, minute, second := valueOr(parts.hour, 0), valueOr(parts.min, 0), valueOr(parts.sec, 0)
	offset := valueOr(parts.offsetSeconds, 0)

	if mon < 1 || mon > 12 || mday < 1 || mday > 31 || hour < 0 || hour > 24 || minute < 0 || minute > 59 ||
		second < 0 || second > 60 || (hour == 24 && (minute > 0 || second > 0 || parts.nanos > 0)) ||
		offset <= -86400 || offset >= 86400 {
		return nil
	}
	t := time.Date(year, time.Month(mon), mday, hour, minute, second, parts.nanos, time.FixedZone("", offset)).UTC()
	return &t
}

func valueOr(p *int, fallback int) int {
	if p == nil {
		return fallback
	}
	return *p
}

// zoneAbbreviationHours is the part of Ruby's zone table people realistically
// send. Unknown names leave the offset unset, which Rails read as UTC.
var zoneAbbreviationHours = map[string]float64{
	"ut": 0, "gmt": 0, "utc": 0, "z": 0, "wet": 0,
	"est": -5, "edt": -4, "cst": -6, "cdt": -5, "mst": -7, "mdt": -6, "pst": -8, "pdt": -7,
	"akst": -9, "akdt": -8, "hst": -10, "ast": -4, "adt": -3, "nst": -3.5, "ndt": -2.5,
	"bst": 1, "cet": 1, "cest": 2, "met": 1, "mest": 2, "eet": 2, "eest": 3, "msk": 3,
	"ist": 5.5, "jst": 9, "kst": 9, "hkt": 8, "sgt": 8, "aest": 10, "aedt": 11, "acst": 9.5, "awst": 8, "nzst": 12, "nzdt": 13,
	"eastern": -5, "central": -6, "mountain": -7, "pacific": -8, "alaska": -9, "hawaii": -10,
	// Military zones.
	"a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8, "i": 9, "k": 10, "l": 11, "m": 12,
	"n": -1, "o": -2, "p": -3, "q": -4, "r": -5, "s": -6, "t": -7, "u": -8, "v": -9, "w": -10, "x": -11, "y": -12,
}

var numericZonePattern = regexp.MustCompile(`^([-+])(\d+)(?:([,.])(\d+)|:(\d+)(?::(\d+))?)?$`)

// zoneOffsetSeconds ports Date's zone_to_diff for the zones above and numeric
// offsets ("-0700", "-07:00", "+7", "gmt-7", "+5.5").
func zoneOffsetSeconds(zone string) *int {
	z := strings.ToLower(strings.TrimSpace(zone))
	dst := 0.0
	switch {
	case strings.HasSuffix(z, " standard time"):
		z = strings.TrimSuffix(z, " standard time")
	case strings.HasSuffix(z, " daylight time"):
		z, dst = strings.TrimSuffix(z, " daylight time"), 1
	case strings.HasSuffix(z, " dst"):
		z, dst = strings.TrimSuffix(z, " dst"), 1
	}
	if hours, ok := zoneAbbreviationHours[z]; ok {
		seconds := int((hours + dst) * 3600)
		return &seconds
	}

	z = strings.TrimPrefix(strings.TrimPrefix(strings.TrimPrefix(z, "gmt"), "utc"), "ut")
	m := numericZonePattern.FindStringSubmatch(z)
	if m == nil {
		return nil
	}
	sign := 1
	if m[1] == "-" {
		sign = -1
	}
	var seconds int
	switch digits := m[2]; {
	case m[3] != "":
		hours, _ := strconv.ParseFloat(digits+"."+m[4], 64)
		seconds = int(hours * 3600)
	case m[5] != "":
		hours, _ := strconv.Atoi(digits)
		minutes, _ := strconv.Atoi(m[5])
		secs, _ := strconv.Atoi("0" + m[6])
		seconds = hours*3600 + minutes*60 + secs
	case len(digits) <= 2:
		hours, _ := strconv.Atoi(digits)
		seconds = hours * 3600
	case len(digits) <= 4:
		hours, _ := strconv.Atoi(digits[:len(digits)-2])
		minutes, _ := strconv.Atoi(digits[len(digits)-2:])
		seconds = hours*3600 + minutes*60
	case len(digits) <= 6:
		hours, _ := strconv.Atoi(digits[:len(digits)-4])
		minutes, _ := strconv.Atoi(digits[len(digits)-4 : len(digits)-2])
		secs, _ := strconv.Atoi(digits[len(digits)-2:])
		seconds = hours*3600 + minutes*60 + secs
	default:
		return nil
	}
	seconds *= sign
	return &seconds
}
