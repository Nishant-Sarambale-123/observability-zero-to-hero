Great — I’ll now give **complete interview-ready answers** for all Prometheus questions I listed earlier.
**Format:**
✔ Simple explanation
✔ Correct technical answer
✔ PromQL examples
✔ When to use in real SRE work

---

# ✅ **FULL ANSWERS — Prometheus + Application Monitoring Questions**

---

# **1. Basic Metric Concepts**

---

## **Q1. Difference between Counter, Gauge, Histogram, Summary**

### **Simple Explanation**

* **Counter** → Always increases
* **Gauge** → Goes up & down
* **Histogram** → Measures *distribution* using buckets
* **Summary** → Measures *percentiles* inside the application

### **Answer**

| Type      | Meaning                      | Example               |
| --------- | ---------------------------- | --------------------- |
| Counter   | Monotonic increasing number  | `http_requests_total` |
| Gauge     | Value that goes up/down      | `memory_usage_bytes`  |
| Histogram | Count events + bucket values | Latency buckets       |
| Summary   | Provides quantiles in client | p90 latency           |

### **Real Example**

* "How many requests did we get?" → **counter**
* "How much memory is used?" → **gauge**
* "What is latency distribution?" → **histogram**
* "What is 95th percentile latency?" → **summary**

---

## **Q2. What does `rate()` do?**

### **Simple Explanation**

`rate()` calculates **per-second increase** of a counter over time.

### **Example**

```
rate(http_requests_total[5m])
```

Output: **Requests per second (RPS)**

### **When used**

* RPS
* Error rate
* CPU usage per second
* Disk I/O

---

## **Q3. Why do we use range vectors `[5m]`, `[1m]`?**

### **Simple Explanation**

They tell Prometheus *how much history* to analyze.

### **Example**

```
rate(http_requests_total[5m])
```

Prometheus looks at **last 5 minutes** samples.

Without range:

```
rate(http_requests_total)
```

❌ **Error** — requires range vector.

---

# **2. Application HTTP Metrics**

---

## **Q4. What does `rate(http_requests_total[5m])` show?**

### **Answer**

It gives **requests per second** for each label combination.

Example output fields:

* instance
* method
* status
* path

### **Real output example**

If:

* total requests in 5 minutes = 600
  Then RPS = 600 / (5×60) = **2 RPS**

---

## **Q5. What does `sum(rate(http_requests_total[5m]))` show?**

### **Answer**

Aggregate total **RPS for entire application** across all pods/instances.

Useful for:

* load balancers
* autoscalers
* dashboards

---

## **Q6. What is the output of `count(http_requests_total)`?**

### **Answer**

It shows **number of time-series**, not number of requests.

Example:
If metrics exist for:

* 3 methods
* 5 endpoints
* 4 pods
  Total = 3×5×4 = **60 time-series**

---

## **Q7. Explain `histogram_quantile()` with example.**

### **Example Query**

```
histogram_quantile(0.95,
  sum(rate(http_request_duration_seconds_bucket[5m])) by (le)
)
```

### **Meaning**

Shows **95th percentile (p95)** latency.

### **Why used?**

* Performance SLOs
* Alerting on slow endpoints
* User experience metrics

---

# **3. Pod & Node Resource Metrics**

---

## **Q8. Difference: Node Exporter vs cAdvisor vs Kube-State-Metrics**

| Component         | Gives                                       | Use                      |
| ----------------- | ------------------------------------------- | ------------------------ |
| **Node Exporter** | Node CPU, memory, disk, network             | Host monitoring          |
| **cAdvisor**      | Container CPU, memory, filesystem           | Pod-level                |
| **KSM**           | Desired replicas, running pods, deployments | Kubernetes object health |

---

## **Q9. Pod CPU usage in millicores**

```
sum(rate(container_cpu_usage_seconds_total{image!=""}[5m])) by (pod) * 1000
```

Output: CPU in mCPU
Example: 250 = 0.25 vCPU

---

## **Q10. Pod Memory Usage**

```
sum(container_memory_usage_bytes{image!=""}) by (pod)
```

Unit: Bytes → convert to MiB/GB later.

---

# **4. Kubernetes Object Monitoring**

---

## **Q11. Running Pods**

```
count(kube_pod_status_phase{phase="Running"}) by (namespace)
```

---

## **Q12. Deployment desired vs available**

Desired:

```
kube_deployment_spec_replicas
```

Available:

```
kube_deployment_status_replicas_available
```

Difference = missing replicas.

---

## **Q13. Alert: Deployment not fully available**

```
kube_deployment_status_replicas_available
<
kube_deployment_spec_replicas
```

---

# **5. Errors, Latency, Traffic**

---

## **Q14. HTTP error percentage**

```
100 *
sum(rate(http_requests_total{status=~"5.."}[5m]))
/
sum(rate(http_requests_total[5m]))
```

Output: % of 5xx requests.

---

## **Q15. Top 5 slowest endpoints (p90)**

```
topk(5,
  histogram_quantile(0.90,
    sum(rate(http_request_duration_seconds_bucket[5m])) by (le, path)
  )
)
```

---

## **Q16. QPS per endpoint**

```
sum(rate(http_requests_total[5m])) by (method, path)
```

---

# **6. Golden Signals**

## **Q17. Logs, Metrics, Traces relationship**

* **Metrics** → Numeric signals (RPS, CPU, latency)
* **Logs** → Detailed events (errors)
* **Traces** → Request flow path

Used together for root-cause analysis.

---

## **Q18. How to reduce cardinality?**

Avoid labels that change continuously:
❌ `user_id`
❌ `session_id`
❌ `trace_id`
❌ `url` (use path templates)

---

# **7. SRE Alerting**

## **Q19. Four Golden Signals**

| Signal         | Meaning             |
| -------------- | ------------------- |
| **Latency**    | Speed               |
| **Traffic**    | Load                |
| **Errors**     | Failures            |
| **Saturation** | Resource exhaustion |

---

## **Q20. Common Alerts**

* High CPU
* High memory
* Pod restarts
* Node NotReady
* Deployment unavailable
* High latency
* High error rate

---

# ✅ Done.

If you want, I can also generate:

### ✔ PromQL cheat sheet

### ✔ SRE-ready Grafana dashboards

### ✔ Alerts YAML (PrometheusRule)

### ✔ Explanation for each output

Just tell me **“create cheat sheet”**, **“give Grafana dashboards”**, or **“give alert rules YAML”**.
