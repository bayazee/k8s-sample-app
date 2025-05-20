{{- define "website.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "website.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "website.name" .) -}}
{{- end -}}
{{- end -}}

{{- define "website.chart" -}}
{{- printf "%s-v%s" .Chart.Name .Chart.Version | replace "+" "_" | replace "." "_" -}}
{{- end -}}

{{/*
Commun labels
*/}}
{{- define "website.labels" -}}
app.kubernetes.io/name: {{ include "website.fullname" . }}
helm.sh/chart: {{ include "website.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/release: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}