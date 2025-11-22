Here you go —
I added **“USE:” in front of each metric** so you know exactly **what it is used for**.

---

# ✅ **BASIC Node Exporter RAW PromQL Metrics + Their USE**

---

# **1. CPU — Raw Metrics**

```promql
node_cpu_seconds_total
```

**USE:** Base metric for calculating CPU usage %, idle %, per-core usage.

```promql
node_load1
```

**USE:** 1-minute load average.

```promql
node_load5
```

**USE:** 5-minute load average.

```promql
node_load15
```

**USE:** 15-minute load average.

---

# **2. Memory — Raw Metrics**

```promql
node_memory_MemTotal_bytes
```

**USE:** Total system memory.

```promql
node_memory_MemFree_bytes
```

**USE:** Completely free memory (unused).

```promql
node_memory_MemAvailable_bytes
```

**USE:** Memory available for applications (best for % calculations).

```promql
node_memory_Buffers_bytes
```

**USE:** Memory used for block device buffers.

```promql
node_memory_Cached_bytes
```

**USE:** Memory cached by Linux for fast access.

---

# **3. Disk — Raw Metrics**

```promql
node_filesystem_size_bytes
```

**USE:** Total filesystem size.

```promql
node_filesystem_free_bytes
```

**USE:** Free space on disk.

```promql
node_filesystem_avail_bytes
```

**USE:** Available space for non-root user.

```promql
node_disk_reads_completed_total
```

**USE:** Number of disk read operations.

```promql
node_disk_writes_completed_total
```

**USE:** Number of disk write operations.

```promql
node_disk_read_bytes_total
```

**USE:** Total bytes read from disk.

```promql
node_disk_written_bytes_total
```

**USE:** Total bytes written to disk.

---

# **4. Network — Raw Metrics**

```promql
node_network_receive_bytes_total
```

**USE:** Bytes received on network interface.

```promql
node_network_transmit_bytes_total
```

**USE:** Bytes sent on network interface.

```promql
node_network_receive_packets_total
```

**USE:** Packets received.

```promql
node_network_transmit_packets_total
```

**USE:** Packets transmitted.

---

# **5. Load — Raw Metrics**

```promql
node_load1
```

**USE:** 1-minute load → quick CPU stress indicator.

```promql
node_load5
```

**USE:** 5-minute load → medium-term system load.

```promql
node_load15
```

**USE:** 15-minute load → longer-term system load.

---

# **6. Processes — Raw Metrics**

```promql
node_procs_running
```

**USE:** Number of active/running processes.

```promql
node_procs_blocked
```

**USE:** Processes waiting for I/O (disk bottleneck indicator).

```promql
node_processes_max
```

**USE:** Kernel max process limit.

```promql
node_processes
```

**USE:** Total number of processes on system.

---

If you approve this format, I will now give:

### ✅ Operations on these metrics

**CPU %, Memory %, Disk %, IOPS, Network Mbps, Alerts, and Grafana-ready queries.**
