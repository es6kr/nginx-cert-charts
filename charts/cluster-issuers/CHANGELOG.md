# Changelog

## v0.0.1

- Initial release of `nginx-cert-issuers` Helm chart
- Supports creation of multiple `ClusterIssuer` resources for cert-manager
- Configurable via `values.yaml` using global defaults and per-issuer overrides
- Default `ACME` solver: `http01` with `nginx` ingress class
