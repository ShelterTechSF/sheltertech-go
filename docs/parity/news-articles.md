# News article parity

Scope: `GET`, `POST`, `PUT`/`PATCH` and `DELETE` on `/api/news_articles`
(tracker endpoints 33–37). Rails reference: `askdarcel-api` commit
`5a644e810e4d2ece25c378eed1f14c169df967f6`,
`app/controllers/news_articles_controller.rb`, `app/presenters/news_article_presenter.rb`,
`app/models/news_article.rb` and `config/routes.rb`. Go baseline:
`dc91bd4462c176be1bfb5f7511dd3ae4a1bba0ce`.

## How it was checked

Rails (production mode) and Go ran side by side on an internal Podman network
with no internet access, so neither could reach Sentry. Each had its own
Postgres database loaded from the Rails `db/schema.rb`. A script sent 97
identical requests, in the same order, to both. For each request it compared
the status, `Content-Type`, `Cache-Control` and `ETag` headers, the exact
response bytes, and the `news_articles` rows afterwards, including whether
`updated_at` changed. The requests covered the payloads `askdarcel-web` sends, the
Postman collection's wrapped payloads, malformed input, type coercion edge
cases, and every route Rails generated.

Before this change, all 97 cases differed. After it, all 97 match.

## Original differences

- **Responses.** Rails wrapped single articles as `{"news_article": {...}}`;
  Go returned the bare object. Rails formatted times as
  `2026-08-15T00:00:00.000Z`; Go used variable precision (`2026-08-15T00:00:00Z`).
  Go also omitted Rails' `Content-Type` charset, `Cache-Control: max-age=1, public`,
  the weak `ETag`, and 304 responses to `If-None-Match`.
- **Create.** The web app posts to `/api/news_articles/`, a trailing slash that Go
  answered with 404. Go rejected the web's string priority (`"2"`) and blank
  dates (`""`) with 400; Rails stored `2` and `NULL`.
- **Update.** Rails overwrote every field, so a cleared or omitted field became
  `NULL`. Go used `COALESCE` and kept the old value, so admins could not clear a
  date, priority or URL. Go also bumped `updated_at` on writes that changed
  nothing, and rejected `PATCH`.
- **IDs.** Go answered a non-numeric ID with 400. Rails converts the ID with
  Ruby's `to_i`, so `abc` matched no row (404) and `6abc` updated article 6.
- **Errors.** Rails returned `{"status":404,"error":"Not Found"}`-style bodies.
  Go used its own error shape and 405 for unsupported methods.
- **Lists.** Go rejected unknown query parameters with 400 and treated a
  whitespace-only `active` as set. Rails ignored unknown parameters and used
  `present?`, so whitespace returned every article and `active=false` (like
  any other non-blank value) returned only active ones. Go sorted by priority and creation
  time; Rails had no `ORDER BY`.

## Behavior preserved from Rails

- **Params.** JSON bodies are wrapped under `news_article` unless they already
  have that key. Urlencoded, multipart and query-string `news_article[...]` keys
  are parsed like Rack, nils are removed from arrays, and a POST with no content
  type is read as a form. Malformed JSON, bad percent-encoding and conflicting
  form keys return 400. A missing or non-hash `news_article` returns 500, as the
  Rails `NoMethodError` did.
- **Strings.** Values are coerced with Ruby's `to_s` and `inspect`: `true` → `"t"`,
  `1.0e+20` → `"1.0e+20"`, arrays and hashes → `["a", 1]` / `{"k"=>"v"}`.
- **Priority.** Coerced with Ruby's `to_i` (`"abc"` → 0, `" 12abc"` → 12,
  `2.7` → 2, blank → `NULL`). Values outside a 4-byte integer return 500
  without writing anything.
- **Dates.** Parsed like `Time.zone.parse` with `Time.zone` = UTC: offsets
  converted to UTC, day overflow rolled forward (`2026-02-30` → March 2), and
  unparseable, non-string or over-128-character values stored as `NULL`.
  Ruby's Japanese-era, ISO week/ordinal, bare digit-run (`20260815`) and BC
  formats are not ported and store `NULL`.
- **Writes.** Updates overwrite every field and skip the write, keeping
  `updated_at`, when nothing changed. Timestamps are written in UTC and dates
  are truncated to microseconds.
- **Routes.** Trailing slashes, `.json` suffixes, `HEAD`, `PATCH`, and the extra
  `/{news_article_id}/create|index|update|destroy` routes from Rails' `routes.rb`
  are supported. The `update` and `destroy` variants read the ID from the query
  string or body, as Rails did. Every other path or method under
  `/api/news_articles` returns Rails' 404.
- **Responses.** Field order, millisecond UTC timestamps, Rails' JSON error
  bodies, a single-space `text/plain` body for delete, `Cache-Control`, and
  Rack's `ETag` (the first 32 hex digits of the body's SHA-256) all match.

## Behavior changes to already-migrated endpoints

`GET /api/v2/news_articles` (rows 33 and 34) was already served by Go, so these
changes reach production as soon as this deploys, before the web app changes:

- The list has no `ORDER BY`, so the breaking-news carousel shows articles in
  Postgres' physical row order, as it did on Rails, instead of by priority.
- Unknown query parameters are ignored instead of rejected, and a whitespace-only
  `active` returns all articles.

## Not reproduced

Rails' app-wide headers (`X-Frame-Options`, `X-Content-Type-Options`,
`X-Request-Id`, `X-Runtime` and so on) and its CORS middleware apply to every
endpoint, not this controller, and are left for an app-wide decision.
