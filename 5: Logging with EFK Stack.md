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

Let me know if you'd like **interview & scenario-based questions** for this topic as well.
