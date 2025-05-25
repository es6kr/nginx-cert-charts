# host-ip-service

A flexible Helm chart for exposing host IP services as Kubernetes Services and optionally creating Ingress resources per port.

## Features

- Creates a Kubernetes `Endpoints` and `Service` resource to route traffic to a host IP.
- Optionally exposes each port via `Ingress`, with per-port customization.
- Supports global and per-ingress annotations.
- TLS configuration is supported via `ingress.tls`.

## Values

### Top-level values

| Key               | Type     | Description                            | Default                |
|-------------------|----------|----------------------------------------|------------------------|
| `namespace`       | string   | Namespace to deploy resources into     | `default`         |
| `endpoint.name`   | string   | Name of the Endpoint and Service       | `docker-host`          |
| `endpoint.ip`     | string   | IP address to route traffic to         | `172.17.0.1`           |

### `endpoint.ports[]`

| Key                       | Type     | Description                          |
|---------------------------|----------|--------------------------------------|
| `name`                    | string   | Port name                            |
| `port`                    | int      | Port number                          |
| `ingress.enabled`         | bool     | Whether to expose via Ingress        |
| `ingress.host`            | string   | Hostname for Ingress                 |
| `ingress.path`            | string   | Path for Ingress                     |
| `ingress.annotations`     | object   | Extra annotations for this Ingress   |

### `ingress`

| Key                    | Type     | Description                          |
|------------------------|----------|--------------------------------------|
| `annotations`          | object   | Global ingress annotations           |
| `tls`                  | list     | TLS configuration                    |

## Example

```yaml
namespace: docker-host
endpoint:
  name: docker-host
  ip: 172.17.0.1
  ports:
    - name: gitlab
      port: 80
      ingress:
        enabled: true
        host: gitlab.test.com
        path: /
        annotations:
          nginx.ingress.kubernetes.io/proxy-body-size: 50m

ingress:
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  tls:
    - secretName: gitlab-tls
      hosts:
        - gitlab.test.com
