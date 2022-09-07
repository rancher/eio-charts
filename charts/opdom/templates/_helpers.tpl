{{/*
Expand the name of the chart.
We truncate at 63 chars because some Kubernetes name fields are limited to this by the DNS naming spec.
*/}}
{{- define "opdom.name" -}}
{{- default Chart.Name .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Create a default fully qualified app name. */}}
{{- define "opdom.hostname" -}}
{{- required "A hostname for the app is required." .Values.app.hostname | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "opdom.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Selector labels */}}
{{- define "opdom.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opdom.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Common labels */}}
{{- define "opdom.labels" -}}
helm.sh/chart: {{ include "opdom.chart" . }}
{{ include "opdom.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Create the name of the service account to use */}}
{{- define "opdom.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "opdom.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
