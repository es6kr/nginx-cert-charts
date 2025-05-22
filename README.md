# nginx-cert-issuers

A Helm chart for deploying multiple cert-manager `ClusterIssuers` for Let's Encrypt with support for global and per-issuer configuration overrides.

## Features

- Create multiple `ClusterIssuers` for Let's Encrypt (production & staging)
- Support for global defaults (email, ingress class, solvers)
- Per-issuer customization (email, solvers, private key secret)
- Helm templating to manage issuers in a centralized, reusable manner

## Prerequisites

- Kubernetes cluster with [cert-manager](https://cert-manager.io/) installed
- Helm 3.x

## Installation

```bash
helm repo add es6kr https://es6kr.github.io/nginx-cert-issuers
helm install cluster-issuers es6kr/nginx-cert-issuers -f values.yaml
```

Or clone and install locally:

```bash
git clone https://github.com/es6kr/nginx-cert-issuers.git
cd nginx-cert-issuers
helm install cluster-issuers ./ -f values.yaml
```

## Example `values.yaml`

```yaml
global:
  acme: # Defaults for all clusterIssuers below, can be overridden per issuer
    email: your-email@example.com
    solvers:
      - http01:
          ingress:
            class: nginx

clusterIssuers:
  letsencrypt-prod:
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecret: letsencrypt-prod
    # email, solvers will fallback to global.acme

  letsencrypt-staging:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecret: letsencrypt-staging
    email: staging@example.com # overrides global.acme.email
    solvers:
      - http01:
          ingress:
            class: nginx
        selector:
          dnsZones:
            - staging.example.com
```

---

## License

[Apache License 2.0](./LICENSE)