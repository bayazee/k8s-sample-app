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
{{- printf "%s-v%s.appv%s" .Chart.Name .Chart.Version .Chart.AppVersion | replace "+" "_" | replace "." "_" -}}
{{- end -}}
