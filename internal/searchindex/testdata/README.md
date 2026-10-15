`service_rails.json` is the complete record emitted by the Rails `Service` model
serializer for the synthetic service-note parity fixture (case 12, Rails commit
`5a644e810e4d2ece25c378eed1f14c169df967f6`). `service_source.json` combines that
fixture's original service row with the associated data used by the serializer.

The golden comparison intentionally retains field nulls, array order, coordinate
precision, default model columns, and timestamp strings. It is not derived from
the Go builder's output. Live Postgres/HTTP/Algolia checks are described in
`docs/parity/service-notes.md`.
