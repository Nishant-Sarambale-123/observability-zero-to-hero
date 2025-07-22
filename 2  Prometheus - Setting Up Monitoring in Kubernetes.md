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
