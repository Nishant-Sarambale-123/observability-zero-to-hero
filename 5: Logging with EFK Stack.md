### 📘 Day 5: Logging with EFK Stack – Detailed Notes

---

#### 🔍 **Core Concepts**

##### ✅ **Importance of Logging**

* Essential for:

  * **Debugging** application and infrastructure issues
  * **Auditing & compliance**
  * **Monitoring** runtime behavior
  * **Postmortem analysis** in incidents
* In Kubernetes, logs are **ephemeral** unless centralized.

---

#### 🧱 **EFK Stack Overview**

| Component         | Role                                               |
| ----------------- | -------------------------------------------------- |
| **Elasticsearch** | Stores and indexes log data for search & analytics |
| **Fluentbit**     | Lightweight log forwarder; runs as DaemonSet       |
| **Kibana**        | Visualization and querying UI for logs             |

---

#### ⚙️ **Kubernetes Setup Steps**

1. **Elasticsearch**

   * Deploy as a StatefulSet with **persistent volume claims**.
   * Expose via ClusterIP or Ingress.
   * Consider resource limits and node affinity.

2. **Fluentbit**

   * Deployed as a **DaemonSet** so it runs on every node.
   * Reads logs from `/var/log/containers/` and `/var/log/pods/`.
   * Uses input plugins like `tail`, and output plugins like `elasticsearch`.

3. **Configuration**

   * Fluentbit `output.elasticsearch` section should contain:

     ```ini
     [OUTPUT]
         Name          es
         Match         *
         Host          elasticsearch
         Port          9200
         Index         fluentbit
         Type          _doc
     ```
   * Kibana uses **index pattern**: `fluentbit-*`

---

#### 🧹 **Log Parsing in Fluentbit**

* Fluentbit can **enrich and transform logs** using filters:

  * `kubernetes`: Adds pod/namespace/container metadata.
  * `parser`: Applies regex/JSON parsing.
  * `modify`, `nest`, `grep`, `record_modifier`: Various log structuring tools.

* Example:

  ```ini
  [FILTER]
      Name kubernetes
      Match kube.*
      Kube_Tag_Prefix kube.var.log.containers.
      Merge_Log On
  ```

---

#### ⏳ **Log Retention in Elasticsearch**

* Elasticsearch stores logs in **indices**.
* Retention is managed using:

  * **ILM (Index Lifecycle Management)**: Automate rollover and deletion.
  * Example ILM policy:

    ```json
    {
      "policy": {
        "phases": {
          "hot": {
            "actions": {
              "rollover": {
                "max_age": "7d",
                "max_size": "50gb"
              }
            }
          },
          "delete": {
            "min_age": "30d",
            "actions": {
              "delete": {}
            }
          }
        }
      }
    }
    ```

---

#### 📊 **Kibana Usage**

* Access logs via the **Discover** tab.
* Use filters like:

  ```kibana
  kubernetes.namespace_name: "default" AND log: "error"
  ```
* Build dashboards with visualizations: pie charts, line graphs, etc.

---

#### 🧠 **Key Learning Points**

* **Centralized logging** is critical in Kubernetes due to short-lived pods.
* **EFK stack** is a common and powerful setup for collecting, storing, and analyzing logs.
* **Fluentbit** is lightweight and optimized for Kubernetes (unlike Fluentd).
* Proper **parsing and enrichment** of logs improves searchability.
* Use **ILM policies** to manage storage and control cost.

---

Here are **interview and scenario-based questions with answers** for **Day 5: Logging with the EFK Stack (Elasticsearch, Fluentbit, Kibana)** — tailored for Kubernetes and DevOps interviews:

---

## 🎯 **Interview Questions & Answers: EFK Stack**

---

### 📌 *Basic to Intermediate Questions*

---

**1. What is the EFK stack, and what are its components?**
**Answer:**
The EFK stack is a centralized logging solution consisting of:

* **Elasticsearch**: Stores and indexes logs.
* **Fluentbit**: Lightweight log shipper and processor.
* **Kibana**: Visualization and querying UI for logs stored in Elasticsearch.

---

**2. Why is centralized logging important in Kubernetes?**
**Answer:**
In Kubernetes, logs are **ephemeral**—they're lost when a pod is deleted or crashes. Centralized logging ensures:

* Retention of logs
* Easier debugging and audit trails
* Visibility across the entire cluster

---

**3. What is the role of Fluentbit in the EFK stack?**
**Answer:**
Fluentbit acts as a **log forwarder and processor**. It:

* Runs as a **DaemonSet** on each node
* Reads logs from paths like `/var/log/containers/`
* Parses and enriches logs (e.g., with Kubernetes metadata)
* Sends logs to Elasticsearch or other backends

---

**4. How does Fluentbit enrich logs with Kubernetes metadata?**
**Answer:**
Using the `kubernetes` filter in Fluentbit:

```ini
[FILTER]
    Name kubernetes
    Match kube.*
    Merge_Log On
```

This adds metadata like pod name, namespace, container name, etc., to each log record.

---

**5. What is an index pattern in Kibana and why is it needed?**
**Answer:**
An **index pattern** (e.g., `fluentbit-*`) tells Kibana which Elasticsearch indices to query. It helps Kibana understand the log structure, including available fields and time filters.

---

**6. How do you manage log retention in Elasticsearch?**
**Answer:**
Using **ILM (Index Lifecycle Management)** policies, which define:

* **Rollover** conditions (e.g., max age, max size)
* **Retention** duration (e.g., delete after 30 days)
* Automated transitions (e.g., hot → delete phase)

---

**7. What are some common Fluentbit filters and their purpose?**
**Answer:**

* `kubernetes`: Add pod/container metadata
* `parser`: Parse structured logs (e.g., JSON, regex)
* `modify`: Add/rename/remove fields
* `grep`: Filter log messages by patterns

---

**8. What’s the difference between Fluentbit and Fluentd?**
**Answer:**

* **Fluentbit** is **lightweight**, written in C, and optimized for performance — ideal for edge/agent use.
* **Fluentd** is heavier and more feature-rich — better suited as a central aggregator or processor.

---

**9. How does Fluentbit send logs to Elasticsearch?**
**Answer:**
Using the `es` output plugin:

```ini
[OUTPUT]
    Name  es
    Match *
    Host  elasticsearch
    Port  9200
    Index fluentbit
```

---

**10. Can Kibana be used for alerting?**
**Answer:**
Yes, with **Kibana Alerts** (part of the Elastic Stack), you can create alerting rules based on log patterns or thresholds, though it's more common in commercial (Elastic Stack Basic+ tiers).

---

---

## 🧩 **Scenario-Based Questions with Answers**

---

### ✅ *Scenario 1: Logs Missing from Kibana*

> **Your application logs are not appearing in Kibana, but Fluentbit is running. How would you troubleshoot?**

**Answer:**

* Check Fluentbit logs: `kubectl logs -n logging <fluentbit-pod>`
* Verify the **output config** points to the correct Elasticsearch service/port.
* Confirm index creation in Elasticsearch using:

  ```bash
  curl http://<elasticsearch-ip>:9200/_cat/indices?v
  ```
* Ensure Kibana has an index pattern like `fluentbit-*` configured.

---

### ✅ *Scenario 2: Log Volume is Growing Rapidly*

> **Your cluster logs are growing too large and using excessive disk space in Elasticsearch. What can you do?**

**Answer:**

* Apply or tighten **ILM policy** to roll over and delete old logs.
* Example:

  * Rollover after 7 days or 50GB
  * Delete after 30 days
* Reduce log verbosity at the application level (`info` vs `debug`)
* Add filters in Fluentbit to exclude non-essential logs

---

### ✅ *Scenario 3: View Logs by Namespace in Kibana*

> **How can you view logs only for the "dev" namespace in Kibana Discover?**

**Answer:**

* Use the filter:

  ```kibana
  kubernetes.namespace_name: "dev"
  ```
* You can also build a saved search or dashboard using this filter.

---

### ✅ *Scenario 4: Correlate Application Errors*

> **You want to find all application logs containing “timeout” across all pods in Kibana. How would you do it?**

**Answer:**

* Use full-text search in the Discover tab:

  ```kibana
  log: "*timeout*"
  ```

* Optional: Combine with namespace/pod filter:

  ```kibana
  kubernetes.namespace_name: "payment" AND log: "*timeout*"
  ```

---

### ✅ *Scenario 5: Only Part of the Logs Appear*

> **Some applications log correctly, others don’t show up. What might be wrong?**

**Answer:**

* Verify all containers are writing to **stdout/stderr**, as Fluentbit reads from `/var/log/containers/`.
* Check if **Fluentbit match rules** are too restrictive.
* Ensure Kubernetes labels or container names aren’t being excluded in filters.

---

Would you like these as a downloadable PDF, slide deck, or printable flashcards for quick revision?


Let me know if you'd like **interview & scenario-based questions** for this topic as well.
