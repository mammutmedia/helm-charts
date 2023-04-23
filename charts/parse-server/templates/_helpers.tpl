{{/*
Expand the name of the chart.
*/}}
{{- define "parse-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Get namespace of the deployment
*/}}
{{- define "parse-server.namespace" -}}
{{- .Release.Namespace }}
{{- end }}

{{/* Get a comma seperated list of all redis sentinels (add 1 to replicaCount because we start at 0)
*/}}
{{- define "parse-server.redisSentinels" -}}
{{- $repicaCount := .Values.replicaCount }}
{{- $sentinels := list }}
{{- range $i, $e := until (int $repicaCount) }}
{{- $sentinels = append $sentinels (printf "%s-%d.%s.%s.svc.cluster.local:26379" (include "parse-server.fullname" $) $i (include "parse-server.namespace" $) (include "parse-server.namespace" $)) }}
{{- end }}
{{- $sentinels | join "," }}
{{- end }}


{{/*
*/}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "parse-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "parse-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "parse-server.labels" -}}
helm.sh/chart: {{ include "parse-server.chart" . }}
{{ include "parse-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "parse-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "parse-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "parse-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "parse-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
