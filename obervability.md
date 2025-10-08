Prometheus Server: Scrapes & stores time-series metrics.

Alertmanager: Handles alerts (sends to Email, Slack, etc.)

Exporters: Converts application/system metrics into Prometheus format. Common ones:

node_exporter (Node metrics)
kube-state-metrics (K8s object state)
PushGateway: Allows ephemeral/short-lived jobs to push metrics.



EFK Stack Overview
Component	Role
Elasticsearch	Stores and indexes log data for search & analytics
Fluentbit	Lightweight log forwarder; runs as DaemonSet
Kibana	Visualization and querying UI for logs
