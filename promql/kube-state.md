Here you go — **BASIC raw Kube State Metrics (KSM) + their USE**, in the **same style** as Node Exporter list.

These are **direct PromQL metrics, no calculations**, exactly what you collect first from **kube-state-metrics**.

---

# ✅ **BASIC Kube State Metrics (RAW METRICS + USE)**

*(Core categories: Pods, Deployments, ReplicaSets, Nodes, StatefulSets, DaemonSets, PVC, PV, CronJobs, Jobs, Containers)*

---

# **1. POD Metrics (Raw)**

```promql
kube_pod_info
```

**USE:** Pod metadata (node, UID, namespace).

```promql
kube_pod_status_phase
```

**USE:** Pod phase (Running, Pending, Failed, Unknown).

```promql
kube_pod_status_ready
```

**USE:** Pod ready condition.

```promql
kube_pod_status_scheduled
```

**USE:** Whether pod is scheduled on a node.

```promql
kube_pod_container_status_restarts_total
```

**USE:** Container restart count (for crashloop detection).

```promql
kube_pod_container_resource_requests_cpu_cores
```

**USE:** CPU requests of pod containers.

```promql
kube_pod_container_resource_limits_cpu_cores
```

**USE:** CPU limits of pod containers.

```promql
kube_pod_container_resource_requests_memory_bytes
```

**USE:** Memory requests of pod containers.

```promql
kube_pod_container_resource_limits_memory_bytes
```

**USE:** Memory limits of pod containers.

---

# **2. Deployment Metrics (Raw)**

```promql
kube_deployment_created
```

**USE:** Deployment creation time.

```promql
kube_deployment_status_replicas
```

**USE:** Desired replicas.

```promql
kube_deployment_status_replicas_available
```

**USE:** Available replicas.

```promql
kube_deployment_status_replicas_unavailable
```

**USE:** Unavailable replicas.

```promql
kube_deployment_spec_replicas
```

**USE:** Deployment replica specification.

---

# **3. ReplicaSet Metrics (Raw)**

```promql
kube_replicaset_created
```

**USE:** ReplicaSet creation timestamp.

```promql
kube_replicaset_status_replicas
```

**USE:** Current replicas.

```promql
kube_replicaset_spec_replicas
```

**USE:** Desired replicas.

---

# **4. StatefulSet Metrics (Raw)**

```promql
kube_statefulset_created
```

**USE:** StatefulSet creation time.

```promql
kube_statefulset_status_replicas
```

**USE:** Ready/available replicas.

```promql
kube_statefulset_status_replicas_ready
```

**USE:** Useful for HA components (DB, MQ).

```promql
kube_statefulset_spec_replicas
```

**USE:** Desired replicas.

---

# **5. DaemonSet Metrics (Raw)**

```promql
kube_daemonset_created
```

**USE:** DaemonSet creation time.

```promql
kube_daemonset_status_desired_number_scheduled
```

**USE:** Expected pods (one per node).

```promql
kube_daemonset_status_number_misscheduled
```

**USE:** Pods running on wrong nodes.

```promql
kube_daemonset_status_number_unavailable
```

**USE:** Unavailable pods.

---

# **6. Node Metrics (Raw)**

```promql
kube_node_info
```

**USE:** Node labels, OS, kernel, instance type.

```promql
kube_node_status_condition
```

**USE:** Ready / NotReady node health.

```promql
kube_node_status_capacity_cpu_cores
```

**USE:** Node CPU total.

```promql
kube_node_status_capacity_memory_bytes
```

**USE:** Node memory total.

```promql
kube_node_status_allocatable_cpu_cores
```

**USE:** CPU allocatable for pods.

```promql
kube_node_status_allocatable_memory_bytes
```

**USE:** Allocatable memory for pods.

---

# **7. PVC (PersistentVolumeClaim) Metrics (Raw)**

```promql
kube_persistentvolumeclaim_info
```

**USE:** PVC metadata (storage class, volume name).

```promql
kube_persistentvolumeclaim_status_phase
```

**USE:** Bound / Pending.

```promql
kube_persistentvolumeclaim_resource_requests_storage_bytes
```

**USE:** PVC size requested.

---

# **8. PV (PersistentVolume) Metrics (Raw)**

```promql
kube_persistentvolume_info
```

**USE:** PV metadata.

```promql
kube_persistentvolume_status_phase
```

**USE:** Available / Bound / Released.

```promql
kube_persistentvolume_capacity_bytes
```

**USE:** PV total capacity.

---

# **9. CronJob + Job Metrics (Raw)**

### **CronJobs**

```promql
kube_cronjob_created
```

**USE:** CronJob created timestamp.

```promql
kube_cronjob_status_last_schedule_time
```

**USE:** Last time CronJob ran.

### **Jobs**

```promql
kube_job_created
```

**USE:** Job creation timestamp.

```promql
kube_job_status_failed
```

**USE:** Failed pods count.

```promql
kube_job_status_succeeded
```

**USE:** Successful pods count.

```promql
kube_job_status_active
```

**USE:** Active pods for job.

---

# **10. Container Metrics (Raw)**

```promql
kube_pod_container_info
```

**USE:** Container metadata.

```promql
kube_pod_container_status_running
```

**USE:** Container running status.

```promql
kube_pod_container_status_terminated_reason
```

**USE:** Termination reason (OOMKilled, Error).

```promql
kube_pod_container_status_waiting_reason
```

**USE:** Waiting reason (ImagePullBackoff, CrashLoopBackoff).

---

If this is good, I will now send:

### **➡️ Operations on these metrics**

* Deployment readiness %
* Pod restart alerts
* Node allocatable usage %
* PVC usage alerts
* CrashLoop alerts
* Grafana-ready queries

Just say **"give operations"**.
