Here are the **key Prometheus metrics** that are **commonly monitored in production** (especially for **DevOps / Kubernetes interviews**). I’m keeping it **crisp and interview-ready** ✅

---

## 🔹 **Infrastructure / Node Metrics (Node Exporter)**

* `node_cpu_seconds_total` → CPU usage
* `node_memory_MemAvailable_bytes` → Available memory
* `node_memory_MemTotal_bytes` → Total memory
* `node_disk_read_bytes_total` → Disk read I/O
* `node_disk_written_bytes_total` → Disk write I/O
* `node_filesystem_avail_bytes` → Disk free space
* `node_filesystem_size_bytes` → Disk size
* `node_network_receive_bytes_total` → Network RX
* `node_network_transmit_bytes_total` → Network TX

---

## 🔹 **Kubernetes Cluster Metrics (kube-state-metrics)**

* `kube_node_status_condition` → Node readiness
* `kube_pod_status_phase` → Pod state (Running, Pending, Failed)
* `kube_pod_container_status_restarts_total` → Container restarts
* `kube_deployment_status_replicas_available` → Available replicas
* `kube_deployment_spec_replicas` → Desired replicas
* `kube_namespace_status_phase` → Namespace status

---

## 🔹 **Pod / Container Resource Metrics (cAdvisor)**

* `container_cpu_usage_seconds_total` → Container CPU usage
* `container_memory_usage_bytes` → Memory usage
* `container_memory_working_set_bytes` → Actual memory in use
* `container_network_receive_bytes_total` → Network in
* `container_network_transmit_bytes_total` → Network out
* `container_fs_usage_bytes` → Container disk usage

---

## 🔹 **Application Metrics (Custom / App Level)**

* `http_requests_total` → Total HTTP requests
* `http_request_duration_seconds` → Request latency
* `http_requests_in_flight` → Active requests
* `http_response_status_total` → HTTP status codes
* `process_cpu_seconds_total` → App CPU usage
* `process_resident_memory_bytes` → App memory usage

---

## 🔹 **Prometheus Self-Monitoring Metrics**

* `prometheus_tsdb_head_series` → Active time-series
* `prometheus_tsdb_head_chunks` → Memory chunks
* `prometheus_engine_query_duration_seconds` → Query latency
* `prometheus_target_scrapes_exceeded_sample_limit_total` → Scrape issues

---

## 🔹 **Alerting / SLA / SRE Metrics**

* `up` → Target health (1 = UP, 0 = DOWN)
* `ALERTS` → Active alerts
* `ALERTS_FOR_STATE` → Alert state duration
* `apiserver_request_total` → Kubernetes API traffic
* `apiserver_request_duration_seconds` → API latency

---

## 🔹 **Interview One-Line Summary**

> “In Prometheus, we monitor node, Kubernetes, container, application, and Prometheus-self metrics to ensure performance, availability, and reliability.”

If you want, I can also give you:

* 📌 **Top 10 must-know metrics**
* 📊 **PromQL examples**
* 🚨 **Production alert rules**
* 🎯 **Metrics mapped to SLO/SLA**

Just tell me 👍
