{{- define "k3s-infra-base.application" -}}
{{- $componentKey := .componentKey -}}
{{- $root := .root -}}
{{- $c := index $root.Values.components $componentKey -}}
{{- if $c.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ $componentKey }}
  namespace: {{ $root.Values.global.argocd.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: {{ $c.syncWave | quote }}
spec:
  project: {{ $root.Values.global.argocd.project }}
  destination:
    server: {{ $root.Values.global.destination.server }}
    namespace: {{ $c.namespace }}
  source:
    repoURL: {{ $c.chart.repoURL }}
    chart: {{ $c.chart.chart }}
    targetRevision: {{ $c.chart.targetRevision }}
    helm:
      valuesObject: {{ toYaml $c.values | nindent 8 }}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
{{- range ($c.syncOptions | default (list "CreateNamespace=true")) }}
      - {{ . }}
{{- end }}
{{- end }}
{{- end -}}
