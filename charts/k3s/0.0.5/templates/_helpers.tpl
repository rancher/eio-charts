{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}-server
{{- end -}}
{{- define "agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}-agent
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "server.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s-server" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "agent.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s-agent" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a list here that allows us to mount config maps as individual files to avoid making dir read-only
*/}}
{{- define "server.manifestnames" -}}
{{- range $key, $val := .Values.server.manifests }}
          - mountPath: /var/lib/rancher/k3s/server/manifests/{{ $key }}
            name: manifests
            subPath: {{ $key }}
{{- end -}}
{{- end -}}
