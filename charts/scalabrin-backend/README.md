{{ template "chart.header" . }}
{{ template "chart.deprecationWarning" . }}

{{ template "chart.versionBadge" . }}{{ template "chart.typeBadge" . }}{{ template "chart.appVersionBadge" . }}

{{ template "chart.description" . }}

{{ template "chart.homepageLine" . }}

## Installation

### Add Helm repository

```shell
helm repo add mammut-helm https://mammutmedia.github.io/helm-charts/
helm repo update
```

## Install scalabrin-backend chart

```bash
helm install scalabrin-backend mammut-helm/scalabrin-backend
```

## Configuration

The following table lists the configurable parameters of the chart and the default values.

{{ template "chart.valuesSection" . }}
