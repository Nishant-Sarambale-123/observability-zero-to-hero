Here's a detailed breakdown of **Day 4: Instrumentation and Custom Metrics** with key **interview questions and real-world scenarios**, perfect for observability-focused DevOps or SRE interviews:

---

## ✅ **Day 4: Instrumentation and Custom Metrics with Prometheus**

### 📘 **Concepts Covered**

#### 🔧 **Instrumentation**

* Adding code to your app to **expose metrics**.
* Enables **custom business/application-level metrics** (beyond infra).
* Format: Prometheus-readable HTTP endpoint (usually `/metrics`).

---

### 📊 **Metric Types in Prometheus**

| Type          | Description                       | Example                                |
| ------------- | --------------------------------- | -------------------------------------- |
| **Counter**   | Monotonic (only increases)        | `http_requests_total`                  |
| **Gauge**     | Increases or decreases            | `memory_usage`, `temperature`          |
| **Histogram** | Bucketed distributions            | `http_request_duration_seconds_bucket` |
| **Summary**   | Quantiles (e.g., 95th percentile) | Request latency percentiles            |

---

### 💻 **Custom Metrics with Node.js**

Using the **`prom-client`** library:

```js
const client = require('prom-client');
const counter = new client.Counter({
  name: 'requests',
  help: 'Total number of requests'
});

counter.inc(); // Increment counter
```

* Exposes metrics at `/metrics` endpoint
* Automatically follows Prometheus exposition format

---

### 📦 **Deploying to Kubernetes**

* **Dockerfile**:

  ```Dockerfile
  FROM node:18
  WORKDIR /app
  COPY . .
  RUN npm install
  CMD ["node", "server.js"]
  ```
* **K8s Manifest**: Add `port: 3000`, and expose `/metrics`

---

### 🔔 **Alertmanager Setup**

* Define alert rules in Prometheus config (YAML)
* Integrate with:

  * **Slack**
  * **Email**
  * **PagerDuty**
* **Example Alert Rule**:

  ```yaml
  groups:
  - name: container-alerts
    rules:
    - alert: HighMemoryUsage
      expr: container_memory_usage_bytes > 500000000
      for: 5m
      labels:
        severity: warning
      annotations:
        summary: "Container is using high memory"
  ```

---

### 🧠 **Key Learning Outcomes**

* Add metrics directly in your app using code.
* Understand which metric type fits each use case.
* Set up **meaningful alerts** based on custom logic (not just infra metrics).
* Combine instrumentation with Prometheus + Alertmanager for full-stack observability.

---

## 🎯 **Interview Questions + Answers**

### 🔹 Basic & Conceptual

#### 1. **What is instrumentation in the context of observability?**

**Answer**:
Instrumentation is the process of adding code to your application to expose internal metrics (e.g., request count, response time) in a format that Prometheus can scrape.

---

#### 2. **What are the four main metric types in Prometheus?**

**Answer**:

* Counter
* Gauge
* Histogram
* Summary

---

#### 3. **When would you use a Histogram vs. a Summary?**

**Answer**:

* **Histogram**: Good for aggregating distributions (e.g., request duration buckets).
* **Summary**: Provides quantiles (e.g., 95th percentile) but is **not aggregatable** across replicas.

---

### 🔹 Intermediate / Code-based

#### 4. **How do you expose a custom metric in a Node.js app using Prometheus?**

**Answer**:
Using the `prom-client` library:

```js
const client = require('prom-client');
const counter = new client.Counter({ name: 'requests_total', help: 'Total requests' });
app.get('/', (req, res) => {
  counter.inc();
  res.send('Hello');
});
```

---

#### 5. **How do you scrape custom metrics from your application in Kubernetes?**

**Answer**:

* App must expose `/metrics` endpoint
* Add a `ServiceMonitor` or `PodMonitor` in Prometheus Operator
* Ensure correct labels/ports are configured

---

#### 6. **Can you create an alert on a custom metric? How?**

**Answer**:
Yes. Example:

```yaml
- alert: HighCustomMetric
  expr: my_custom_metric > 100
  for: 2m
```

Then configure Alertmanager to route this alert.

---

## 📘 **Scenario-Based Questions**

### 🔸 **Scenario 1: Your app crashes but infra metrics are healthy. How do you find the issue?**

**Answer**:
Add **custom metrics via instrumentation** (e.g., error counts, DB latency). Infra tools like CPU/RAM wouldn’t detect logical errors like memory leaks, failing API routes, etc.

---

### 🔸 **Scenario 2: How would you monitor how long each API request takes?**

**Answer**:
Use **Histogram** or **Summary**:

```js
const histogram = new client.Histogram({
  name: 'api_duration_seconds',
  help: 'API response duration',
  buckets: [0.1, 0.3, 0.5, 1, 2, 5] // seconds
});
```

---

### 🔸 **Scenario 3: One pod shows consistently high request latency. How do you alert on this?**

**Answer**:
Use a Histogram-based alert:

```yaml
expr: rate(api_duration_seconds_bucket{le="1"}[5m]) < 0.9
```

This means less than 90% of requests complete in under 1 second.

---

Would you like:

* A ready-to-use Node.js + Prometheus example repo?
* Kubernetes ServiceMonitor YAML example?
* Alertmanager Slack integration steps?
Here’s a well-organized list of **Prometheus Instrumentation and Custom Metrics Interview Questions, Answers, and Real-World Scenarios** specifically for **Day 4** of your observability journey.

---

## 🎯 **Interview Questions and Answers**

---

### 🔹 **Basic Questions**

#### 1. **What is instrumentation in Prometheus?**

**Answer**:
Instrumentation is the process of modifying your application code to expose **custom metrics** (e.g., number of requests, API latency) in a Prometheus-readable format, usually via an HTTP endpoint like `/metrics`.

---

#### 2. **What are the four metric types in Prometheus?**

**Answer**:

1. **Counter** – Only increases (e.g., total API requests)
2. **Gauge** – Can increase/decrease (e.g., memory usage, temperature)
3. **Histogram** – Tracks distributions across **predefined buckets** (e.g., response time buckets)
4. **Summary** – Tracks **quantiles** (e.g., 95th percentile latency), non-aggregatable across replicas

---

#### 3. **Which metric type would you use to measure request duration?**

**Answer**:
Use **Histogram** (for bucketed latency analysis) or **Summary** (for percentile-based latency analysis).

---

#### 4. **What’s the difference between a Histogram and Summary?**

**Answer**:

| Metric Type   | Aggregatable | Use Case                                                        |
| ------------- | ------------ | --------------------------------------------------------------- |
| **Histogram** | ✅ Yes        | Distribution buckets, suitable for aggregating across instances |
| **Summary**   | ❌ No         | Quantiles like 95th/99th percentile, per-instance insights      |

---

### 🔹 **Intermediate Questions**

#### 5. **How do you expose a custom metric in a Node.js application using Prometheus?**

**Answer**:
Use the `prom-client` library:

```js
const client = require('prom-client');
const counter = new client.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests'
});

counter.inc(); // Increment counter on request
```

Then expose `/metrics` using an HTTP server.

---

#### 6. **What is a `ServiceMonitor`, and why is it needed?**

**Answer**:
A `ServiceMonitor` is a CRD used by the Prometheus Operator to specify how to scrape a Kubernetes service. It defines **targets, ports, paths, and labels** that Prometheus should monitor.

---

#### 7. **How do you alert on a custom metric like `http_errors_total`?**

**Answer**:
Create a Prometheus alert rule:

```yaml
- alert: HighHttpErrors
  expr: rate(http_errors_total[5m]) > 5
  for: 2m
  labels:
    severity: critical
  annotations:
    summary: "High number of HTTP errors"
```

---

#### 8. **How do you integrate Alertmanager with Slack or Email?**

**Answer**:

* Edit `alertmanager.yaml` config:

```yaml
receivers:
- name: 'slack-notifier'
  slack_configs:
  - channel: '#alerts'
    send_resolved: true
    api_url: '<slack_webhook_url>'
```

* Link to the alert route in `routes:` section.
* Reload Alertmanager.

---

## 📘 **Real-World Scenario-Based Questions**

---

### 🔸 **Scenario 1: Application is up, but customers report high latency. Infra metrics (CPU, RAM) look normal. What would you do?**

**Answer**:

* Infra metrics may not capture application-level issues.
* Instrument your app with **Histogram metrics** to capture latency buckets:

```js
const histogram = new client.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Request duration',
  buckets: [0.1, 0.3, 0.5, 1, 2]
});
```

* Analyze latency distribution in Prometheus or Grafana.
* Set alerts on high latency percentiles or bucket thresholds.

---

### 🔸 **Scenario 2: You deploy a new version of an app, and errors spike. How would you track and alert on this?**

**Answer**:

* Add a **Counter metric** like `http_errors_total`.
* Alert using:

```yaml
expr: increase(http_errors_total[5m]) > 10
```

* Correlate with deployments using `deployment_revision` labels.

---

### 🔸 **Scenario 3: You want to ensure 99% of requests finish under 1 second. How would you monitor this?**

**Answer**:

* Use a **Histogram** with buckets up to 1 second.
* Create this PromQL alert:

```promql
(
  rate(http_request_duration_seconds_bucket{le="1"}[5m])
  /
  rate(http_request_duration_seconds_count[5m])
) < 0.99
```

* Alert if the ratio drops below 99%.

---

### 🔸 **Scenario 4: You are asked to build an SLO dashboard. What metrics would you instrument?**

**Answer**:

* **Total requests**
* **Failed requests**
* **Latency (Histogram or Summary)**
* **Availability uptime**

Use metrics like:

```promql
rate(http_requests_total[1m])
rate(http_errors_total[1m])
```

Build **SLI = Success / Total**, then apply SLO threshold (e.g., 99.9%).

---

Would you like a sample:

* Node.js project with `prom-client`?
* Complete Alertmanager + Prometheus + Slack config?
* ServiceMonitor YAML for custom-metric scraping in Kubernetes?
