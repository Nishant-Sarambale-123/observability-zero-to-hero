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

Absolutely! Here's a **full mock Q\&A format** with **answers** for both the **interview questions** and **scenario-based questions** for **Day 3: Metrics and PromQL in Prometheus**:

---

### 🎯 **Interview Questions with Answers: Prometheus Metrics & PromQL**

#### 📌 *Basic-Level Questions*

---

**1. What is PromQL and why is it used?**
**Answer:**
PromQL (Prometheus Query Language) is a powerful query language used in Prometheus to retrieve and manipulate time-series data. It allows users to perform aggregations, filter metrics based on labels, calculate rates, and build dashboards and alerts.

---

**2. Explain the difference between `rate()` and `irate()` in PromQL.**
**Answer:**

* `rate()`: Calculates the average per-second increase rate of a counter over a given range (e.g., 1m, 5m).
* `irate()`: Calculates the per-second rate between the last two data points.
  Use `rate()` for stable long-term trends, and `irate()` for capturing sudden spikes.

---

**3. What are vector types in Prometheus?**
**Answer:**
Prometheus has:

* **Instant Vector**: Set of time series with the most recent sample.
* **Range Vector**: Set of time series with a range of data points over a specified time window.

---

**4. How does Prometheus store and retrieve metrics?**
**Answer:**
Prometheus stores metrics as time-series data identified by a metric name and a set of key-value labels. Data is pulled from exporters via HTTP at scrape intervals and stored in a time-series database (TSDB). Queries retrieve data using PromQL.

---

**5. What is a Range Vector and how is it used in PromQL queries?**
**Answer:**
A range vector represents a series of datapoints over a time interval. It is used for functions like `rate()` or `increase()`.
Example:

```promql
rate(http_requests_total[5m])
```

---

**6. Give an example of filtering a metric using labels.**
**Answer:**

```promql
http_requests_total{method="POST", status="500"}
```

This filters metrics where method is `POST` and status is `500`.

---

**7. How do you use the `sum()` and `avg()` functions in PromQL?**
**Answer:**

* `sum()`: Adds values across series.
  Example: `sum(rate(http_requests_total[1m]))`
* `avg()`: Computes the average value.
  Example: `avg(container_memory_usage_bytes) by (pod)`

---

**8. What is the difference between `==` and `and` in PromQL?**
**Answer:**

* `==` is a **comparison operator**: evaluates if values are equal.
* `and` is a **set operator**: returns only time series that exist in both operands and have matching labels.

---

**9. How do counters and gauges differ in Prometheus?**
**Answer:**

* **Counters**: Monotonically increasing values (e.g., request counts).
* **Gauges**: Can go up and down (e.g., memory usage, temperature).

---

**10. How can you detect if a pod or service is down using PromQL?**
**Answer:**
Use the `up` metric. If a service is unreachable, `up == 0`.

```promql
up == 0
```

---

### 🧩 **Scenario-Based Questions with Answers**

---

**✅ Scenario 1: Alert on High HTTP Error Rate**

> **PromQL Query:**

```promql
sum(rate(http_requests_total{status=~"5.."}[5m])) 
/ 
sum(rate(http_requests_total[5m])) 
> 0.05
```

**Explanation:** Calculates the ratio of 5xx errors to total HTTP requests in the last 5 minutes. If the ratio exceeds 5%, it triggers an alert.

---

**✅ Scenario 2: Identify High CPU Consuming Pods**

> **PromQL Query:**

```promql
topk(5, rate(container_cpu_usage_seconds_total[1m]))
```

**Explanation:** Lists top 5 pods based on CPU usage rate over the past 1 minute.

---

**✅ Scenario 3: Memory Usage by Namespace**

> **PromQL Query:**

```promql
sum(container_memory_usage_bytes) by (namespace)
```

**Explanation:** Aggregates memory usage for all pods grouped by their namespace.

---

**✅ Scenario 4: Detect Unavailable Services**

> **PromQL Query:**

```promql
up == 0
```

**Explanation:** Flags targets that Prometheus failed to scrape — indicating a service is down.

---

**✅ Scenario 5: Monitoring Request Rate for a Specific App**

> **PromQL Query:**

```promql
rate(http_requests_total{app="payment-service"}[1m])
```

**Explanation:** Shows the per-second rate of HTTP requests to the `payment-service` over the past 1 minute.

---

**✅ Scenario 6: Combine Metrics Using Boolean Logic**

> **PromQL Query:**

```promql
(container_memory_usage_bytes > 500000000) 
and 
(rate(container_cpu_usage_seconds_total[1m]) < 0.01)
```

**Explanation:** Finds pods using more than 500MB memory and less than 0.01 CPU — helpful in identifying inefficient workloads.

---

**✅ Scenario 7: Alerting on Node Disk Usage**

> **PromQL Query:**

```promql
(1 - (node_filesystem_free_bytes / node_filesystem_size_bytes)) > 0.9
```

**Explanation:** Calculates disk usage ratio. Triggers alert when usage exceeds 90%.

---

Let me know if you'd like these compiled into a printable document or visual flashcards for revision.

