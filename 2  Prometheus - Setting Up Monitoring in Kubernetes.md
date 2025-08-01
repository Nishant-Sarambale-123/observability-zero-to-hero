Here's a concise **Day 2 Summary** of your Prometheus learning journey, tailored for interviews or note-sharing:

---

### ✅ **Day 2: Prometheus - Setting Up Monitoring in Kubernetes (EKS)**

#### 📘 **Core Concepts**

* **Prometheus**:

  * A **time-series** database and **monitoring system**
  * **Pull-based model**: Prometheus **scrapes metrics** from target endpoints
  * Stores data with **timestamp + labels**

#### 🏗️ **Prometheus Architecture**

* **Prometheus Server**:
  Scrapes & stores time-series metrics.
* **Alertmanager**:
  Handles alerts (sends to Email, Slack, etc.)
* **Exporters**:
  Converts application/system metrics into Prometheus format.
  Common ones:

  * `node_exporter` (Node metrics)
  * `kube-state-metrics` (K8s object state)
* **PushGateway**:
  Allows ephemeral/short-lived jobs to **push** metrics.

---

#### ☁️ **Prometheus Setup on EKS (Kubernetes)**

* **Recommended Method**:
  Use `kube-prometheus-stack` via **Helm** (includes Prometheus, Alertmanager, Grafana, etc.)
* **Steps**:

  ```bash
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
  helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack
  ```
* Components installed:

  * Prometheus Server
  * Grafana (UI)
  * Alertmanager
  * Exporters

---

#### 📊 **Grafana Integration**

* Access Grafana via **NodePort/Ingress/Service URL**
* Use **imported dashboards** for:

  * Kubernetes metrics
  * Node metrics
  * Pod/container metrics

---

#### 🔎 **Basic Prometheus Queries in Grafana**

| Query                          | Purpose                                        |
| ------------------------------ | ---------------------------------------------- |
| `up`                           | Shows status of all targets (1 = up, 0 = down) |
| `node_cpu_seconds_total`       | CPU time consumed by nodes                     |
| `container_memory_usage_bytes` | Memory usage per container                     |

---

### 🧠 **Key Learning Outcomes**

* Set up full Prometheus monitoring stack in Kubernetes (EKS).
* Visualized metrics through **Grafana dashboards**.
* Understood how **exporters**, **Alertmanager**, and **queries** fit into observability.

---

Let me know if you'd like:

* Real-world interview questions from this topic
* A **hands-on scenario** or YAML deployment reference
* More **PromQL query examples**
Here are **Prometheus Interview Questions and Scenario-Based Questions** along with their **answers**, especially focused on Kubernetes (EKS) and real-world monitoring:

---

### 🔹 **Basic Interview Questions**

#### 1. **What is Prometheus?**

**Answer**:
Prometheus is an open-source time-series database and monitoring system. It uses a **pull-based model** to scrape metrics from targets, and it stores these metrics in a time-stamped, label-based format.

---

#### 2. **How does Prometheus collect metrics?**

**Answer**:
Prometheus scrapes metrics over HTTP from **instrumented targets** using a **pull model** at configured intervals.

---

#### 3. **What are Exporters in Prometheus?**

**Answer**:
Exporters are agents or services that **expose metrics** in Prometheus format.
Examples:

* `node_exporter`: For system-level metrics
* `kube-state-metrics`: For Kubernetes object states

---

#### 4. **What is the use of Alertmanager?**

**Answer**:
Alertmanager handles alerts sent by Prometheus. It manages **deduplication, grouping, silencing**, and **notification routing** (to email, Slack, PagerDuty, etc.).

---

#### 5. **Difference between PushGateway and Exporters?**

**Answer**:

* **Exporters** expose metrics that Prometheus pulls.
* **PushGateway** is used for **short-lived jobs** that can't be scraped directly, so the job **pushes** its metrics to the gateway.

---

#### 6. **How do you install Prometheus in Kubernetes (EKS)?**

**Answer**:
Using Helm:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install my-monitor prometheus-community/kube-prometheus-stack
```

---

### 🔹 **Intermediate / PromQL Questions**

#### 7. **What does the `up` metric in Prometheus mean?**

**Answer**:
The `up` metric shows if the target is reachable.

* `1` = Target is up
* `0` = Target is down

---

#### 8. **How to monitor CPU usage using Prometheus?**

**Answer**:
Use `rate` with `node_cpu_seconds_total`:

```promql
rate(node_cpu_seconds_total{mode!="idle"}[5m])
```

This shows CPU usage over time, excluding idle time.

---

#### 9. **How would you monitor container memory usage?**

**Answer**:

```promql
container_memory_usage_bytes{container!="", pod!=""}
```

This returns memory usage per container.

---

### 🔹 **Advanced / Scenario-Based Questions**

#### 10. **Scenario**: You installed Prometheus on EKS but are not seeing any data in Grafana. How will you troubleshoot?

**Answer**:

* Check if **Prometheus pods are running** (`kubectl get pods`)
* Verify **targets are reachable** (`/targets` page in Prometheus UI)
* Confirm **exporters like `node_exporter` or `kube-state-metrics`** are deployed
* Check Grafana **data source** is correctly set to Prometheus
* Inspect **firewall or network policies**

---

#### 11. **Scenario**: You want to alert when a node’s memory usage exceeds 90%. How would you do it?

**Answer**:

1. Create a PromQL expression:

```promql
100 * (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) > 90
```

2. Define an alert rule in `prometheus.rules.yaml`:

```yaml
groups:
- name: node-alerts
  rules:
  - alert: HighMemoryUsage
    expr: 100 * (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) > 90
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Node memory usage is above 90%"
```

---

#### 12. **Scenario**: How can you reduce the number of alerts during a scheduled maintenance window?

**Answer**:

* Use **Alertmanager's "silence" feature** to temporarily suppress alerts for affected targets.
* Alternatively, configure **alert rules** with specific time windows using custom logic or labels.

---

#### 13. **Scenario**: Prometheus server is consuming too much memory. What are possible reasons?

**Answer**:

* Too many high-cardinality metrics (e.g., labels with pod UID or request path)
* Very short scrape intervals (too frequent scraping)
* Long retention periods (default is 15 days)
* Use of many recording rules or large dashboards with heavy PromQL queries

---

Would you like:

* YAML snippets for alert rules?
* Grafana dashboard import steps?
* More PromQL queries categorized by CPU, memory, pods, nodes, etc.?
