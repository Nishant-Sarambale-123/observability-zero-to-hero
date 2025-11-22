Here are **Application-Level PromQL Queries** — the metrics you use to monitor **your application**, not the node or Kubernetes.

These work with **app-level instrumented metrics** (Prometheus client libraries: Python, Go, Java, Node.js, .NET).

I’ll give you **basic raw metrics + their use** → exactly same style as Node Exporter / KSM raw lists.

---

# ✅ **APPLICATION-LEVEL RAW METRICS (NO CALCULATION — ONLY BASICS)**

These come from your application instrumentation (e.g., `/metrics` from app).

---

# **1. HTTP Request Metrics (Raw)**

```promql
http_requests_total
```

**USE:** Total HTTP requests received (used for RPS, error rate).

```promql
http_request_duration_seconds_count
```

**USE:** Number of requests measured (used for latency).

```promql
http_request_duration_seconds_sum
```

**USE:** Total time spent on requests (used for avg latency).

```promql
http_response_size_bytes
```

**USE:** Raw response size metric.

---

# **2. gRPC Request Metrics (Raw)**

*(If app uses gRPC)*

```promql
grpc_server_handled_total
```

**USE:** Total gRPC requests handled.

```promql
grpc_server_handling_seconds_count
```

**USE:** Count for duration buckets.

```promql
grpc_server_handling_seconds_sum
```

**USE:** Total time processing RPC calls.

---

# **3. Application Errors (Raw)**

```promql
application_errors_total
```

**USE:** App-specific errors (exceptions, failures).

```promql
http_requests_total{status=~"5.."}
```

**USE:** Count of 5xx responses.

```promql
http_requests_total{status=~"4.."}
```

**USE:** Count of 4xx responses.

---

# **4. Application-Specific Business Metrics (Raw)**

(depends on your app, examples below)

```promql
orders_created_total
```

**USE:** E-commerce apps: new orders.

```promql
payments_failed_total
```

**USE:** Failed payments.

```promql
messages_processed_total
```

**USE:** MQ/Stream processing.

```promql
jobs_queued
```

**USE:** Queue length.

---

# **5. Cache Metrics (Redis/Memcached within app)**

```promql
cache_hits_total
```

**USE:** Number of cache hits.

```promql
cache_misses_total
```

**USE:** Cache misses.

```promql
cache_latency_seconds_count
```

**USE:** Count of cache operations.

```promql
cache_latency_seconds_sum
```

**USE:** Sum for latency calculation.

---

# **6. Database Query Metrics (App instrumented)**

```promql
db_queries_total
```

**USE:** Number of DB queries.

```promql
db_query_duration_seconds_count
```

**USE:** Count of DB duration samples.

```promql
db_query_duration_seconds_sum
```

**USE:** Sum of DB latency (for avg/percentile).

```promql
db_query_errors_total
```

**USE:** DB error count.

---

# **7. Background Job / Worker Metrics**

```promql
worker_jobs_total
```

**USE:** Jobs processed by workers.

```promql
worker_jobs_failed_total
```

**USE:** Failed background jobs.

```promql
worker_job_duration_seconds_count
```

**USE:** Worker duration samples.

```promql
worker_job_duration_seconds_sum
```

**USE:** Total duration time.

---

# **8. Application Resource Metrics (Instrumented, not Node itself)**

```promql
process_cpu_seconds_total
```

**USE:** App CPU usage (raw counter).

```promql
process_resident_memory_bytes
```

**USE:** App memory usage (RSS).

```promql
process_virtual_memory_bytes
```

**USE:** App virtual memory.

```promql
process_open_fds
```

**USE:** Open file descriptors used.

---

# **9. Queue System Metrics (RabbitMQ/Kafka inside App)**

```promql
queue_messages_ready
```

**USE:** Messages waiting to be consumed.

```promql
queue_messages_unacked
```

**USE:** Unacknowledged (stuck) messages.

```promql
queue_consumers
```

**USE:** Number of active consumers.

---

# **10. Custom Business KPIs (Example)**

You can expose anything:

```promql
user_login_total
```

**USE:** Logins in app.

```promql
notification_sent_total
```

**USE:** Notifications triggered.

```promql
payment_retries_total
```

**USE:** Number of payment retry attempts.

---

# ✅ Ready for the next step?

If you want, I will now send:

### **➡️ Application-Level Operations:**

* Request Per Second (RPS)
* Error rate %
* Latency p50 / p90 / p99
* Cache hit ratio
* DB query latency %
* Worker job success rate
* App CPU %, memory %
* SLO / SLIs PromQL

Just say **"give operations"**.
