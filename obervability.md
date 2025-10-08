Prometheus Server: Scrapes & stores time-series metrics.

Alertmanager: Handles alerts (sends to Email, Slack, etc.)

Exporters: Converts application/system metrics into Prometheus format. Common ones:

node_exporter (Node metrics)
kube-state-metrics (K8s object state)
PushGateway: Allows ephemeral/short-lived jobs to push metrics.



