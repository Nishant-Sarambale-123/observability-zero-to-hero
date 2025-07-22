### 📘 Day 3: Metrics and PromQL in Prometheus – Detailed Notes

---

#### 🔍 **Core Concepts: PromQL (Prometheus Query Language)**

* **Purpose**:
  PromQL is used to **query and analyze** time-series data collected by Prometheus.

* **Nature**:
  Vector-based and optimized for operations over time-series (labels + values).

---

#### 🔡 **Basic PromQL Syntax**

* **Raw Metric Query**:

  ```
  http_requests_total
  ```

  → Returns all time series with the metric `http_requests_total`.

* **Filtering by Labels**:

  ```
  http_requests_total{method="GET", status="200"}
  ```

  → Filters metrics where `method=GET` and `status=200`.

* **Time Ranges (Range Vectors)**:

  ```
  rate(http_requests_total[5m])
  ```

  → Calculates per-second rate over the last 5 minutes.

---

#### ➕ **Aggregations in PromQL**

| Function  | Description                                    | Example                                                       |
| --------- | ---------------------------------------------- | ------------------------------------------------------------- |
| `sum()`   | Total across time series                       | `sum(rate(http_requests_total[5m]))`                          |
| `avg()`   | Average                                        | `avg(rate(container_cpu_usage_seconds_total[1m])) by (pod)`   |
| `min()`   | Minimum value                                  | `min(container_memory_usage_bytes) by (container)`            |
| `max()`   | Maximum value                                  | `max(cpu_usage_seconds_total) by (node)`                      |
| `count()` | Number of series matched                       | `count(container_network_receive_bytes_total) by (namespace)` |
| `rate()`  | Per-second average rate (counter type metrics) | `rate(http_requests_total[1m])`                               |
| `irate()` | Instantaneous rate (last two points only)      | `irate(http_requests_total[1m])`                              |

---

#### 🔧 **Operators in PromQL**

* **Arithmetic Operators**
  `+`, `-`, `*`, `/`
  Example:

  ```
  cpu_usage_total / cpu_capacity_total
  ```

* **Comparison Operators**
  `==`, `!=`, `>`, `<`
  Example:

  ```
  node_memory_Active_bytes > 500000000
  ```

* **Boolean Logic**

  * `and`: Intersection of time series
  * `or`: Union of time series
  * `unless`: Set difference
    Example:

  ```
  up == 0 or http_requests_total > 1000
  ```

---

#### 📊 **Practical Use Cases**

* **Check if services are up**:

  ```
  up == 0
  ```

* **Total HTTP requests grouped by status code**:

  ```
  sum(rate(http_requests_total[5m])) by (status_code)
  ```

* **Top 5 CPU consuming pods**:

  ```
  topk(5, rate(container_cpu_usage_seconds_total[1m]))
  ```

* **Memory usage by namespace**:

  ```
  sum(container_memory_usage_bytes) by (namespace)
  ```

---

#### 🧠 **Key Learning Points**

* PromQL allows deep and flexible analysis of **time-series metrics**.
* You can build **custom Grafana dashboards** and **alerting rules** using PromQL queries.
* Mastering PromQL helps you correlate issues across services and perform root cause analysis.
* Filtering and aggregating over **labels** (e.g., pod, namespace, status) is critical in Kubernetes observability.

---

Let me know if you'd like interview and scenario questions for this topic as well.
