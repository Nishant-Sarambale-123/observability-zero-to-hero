Excellent 👍 — **PromQL (Prometheus Query Language)** is an **important interview topic** for DevOps, SRE, and monitoring roles.

Below is a list of **important PromQL queries** that are **commonly asked in interviews**, explained in **very simple words** so you can understand and remember easily 👇

---

## 🧠 **1. Basic Metric Queries**

| Query                              | Meaning                          | Example Use                                                     |
| ---------------------------------- | -------------------------------- | --------------------------------------------------------------- |
| `up`                               | Shows which targets are up/down. | `up{job="node"}` → returns 1 if node exporter is up, 0 if down. |
| `node_cpu_seconds_total`           | Shows total CPU time used.       | See CPU usage per core.                                         |
| `node_memory_MemAvailable_bytes`   | Shows available memory.          | Monitor available memory on servers.                            |
| `node_disk_read_bytes_total`       | Disk read bytes.                 | Track disk reads over time.                                     |
| `node_network_receive_bytes_total` | Network received bytes.          | Check incoming network traffic.                                 |

---

## ⚙️ **2. Rate & Increase (very commonly asked)**

| Query                  | Meaning                                              | Simple Example                                                           |
| ---------------------- | ---------------------------------------------------- | ------------------------------------------------------------------------ |
| `rate(metric[5m])`     | Calculates per-second average change over 5 minutes. | `rate(http_requests_total[5m])` → request rate per second.               |
| `increase(metric[1h])` | Total increase in the metric over 1 hour.            | `increase(http_requests_total[1h])` → number of requests in last 1 hour. |

🟢 **Interview Tip:**
👉 *They may ask difference between `rate()` and `increase()`:*

* `rate()` = per second speed
* `increase()` = total count increase

---

## 🧩 **3. CPU Usage Queries**

| Query                                                                            | Meaning                            | Example                               |
| -------------------------------------------------------------------------------- | ---------------------------------- | ------------------------------------- |
| `100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)` | Shows CPU usage percentage.        | “What’s the CPU usage of the server?” |
| `avg by (instance)(rate(node_cpu_seconds_total{mode!="idle"}[5m]))`              | Shows active CPU usage (non-idle). | Used in Grafana dashboards.           |

---

## 💾 **4. Memory Usage Queries**

| Query                                                                                              | Meaning                  | Example                        |
| -------------------------------------------------------------------------------------------------- | ------------------------ | ------------------------------ |
| `(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100` | Memory usage percentage. | Shows memory utilization in %. |
| `node_memory_MemFree_bytes`                                                                        | Free memory in bytes.    | Basic memory check.            |

---

## 💿 **5. Disk Usage Queries**

| Query                                                                                          | Meaning                | Example                     |
| ---------------------------------------------------------------------------------------------- | ---------------------- | --------------------------- |
| `(node_filesystem_size_bytes - node_filesystem_free_bytes) / node_filesystem_size_bytes * 100` | Disk usage percentage. | Shows used disk space in %. |
| `node_disk_reads_completed_total`                                                              | Total disk reads.      | Monitor disk activity.      |

---

## 🌐 **6. Network Usage Queries**

| Query                                         | Meaning                              | Example                     |
| --------------------------------------------- | ------------------------------------ | --------------------------- |
| `rate(node_network_receive_bytes_total[5m])`  | Incoming network traffic per second. | Check network input speed.  |
| `rate(node_network_transmit_bytes_total[5m])` | Outgoing network traffic per second. | Check network output speed. |

---

## 🧩 **7. HTTP / Application Level Queries**

| Query                                                                                                   | Meaning                                           | Example                          |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------- | -------------------------------- |
| `sum(rate(http_requests_total[5m])) by (status)`                                                        | Total requests per second grouped by status code. | See 200, 404, 500 request rates. |
| `sum(rate(http_request_duration_seconds_sum[5m])) / sum(rate(http_request_duration_seconds_count[5m]))` | Average request latency.                          | Shows average response time.     |
| `histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))`                 | 95th percentile latency.                          | Used for SLA/SLO dashboards.     |

---

## 🚨 **8. Alert-based Queries (used in alert rules)**

| Query                                                   | Meaning               | Example                                    |
| ------------------------------------------------------- | --------------------- | ------------------------------------------ |
| `up == 0`                                               | Target down.          | Trigger alert if service is not reachable. |
| `node_filesystem_free_bytes < 5 * 1024 * 1024 * 1024`   | Disk space below 5GB. | Low disk alert.                            |
| `rate(node_cpu_seconds_total{mode="idle"}[5m]) < 0.2`   | High CPU usage.       | CPU > 80% alert.                           |
| `sum(rate(http_requests_total{status=~"5.."}[5m])) > 0` | Server errors > 0.    | Alert on HTTP 5xx errors.                  |

---

## 🧮 **9. Aggregation Functions (interview favorite)**

| Function  | Meaning               | Example                                                    |
| --------- | --------------------- | ---------------------------------------------------------- |
| `sum()`   | Add up values.        | `sum(rate(http_requests_total[5m]))` = total requests.     |
| `avg()`   | Average.              | `avg(rate(http_requests_total[5m]))` = avg request rate.   |
| `max()`   | Maximum.              | `max(node_memory_MemFree_bytes)` = most free memory node.  |
| `min()`   | Minimum.              | `min(node_memory_MemFree_bytes)` = least free memory node. |
| `count()` | Count of time series. | `count(up == 1)` = number of up targets.                   |

---

## 📋 **10. Common Interview Q&A Style Examples**

| Question                                    | Example Answer                                                                          |
| ------------------------------------------- | --------------------------------------------------------------------------------------- |
| **Q:** How to check which nodes are down?   | `up == 0`                                                                               |
| **Q:** How to find total HTTP request rate? | `sum(rate(http_requests_total[5m]))`                                                    |
| **Q:** How to check CPU usage in %?         | `100 - avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100`          |
| **Q:** How to see 5xx errors per second?    | `sum(rate(http_requests_total{status=~"5.."}[5m]))`                                     |
| **Q:** How to get 95th percentile latency?  | `histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))` |

---

Would you like me to give you a **“Top 20 PromQL questions with answers (interview format)”** next?
That list includes direct Q&A style answers you can revise quickly before interviews.
