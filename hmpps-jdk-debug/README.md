# HMPPS JDK Debug Image

A JDK image based on Eclipse Temurin 25 for use as a Kubernetes ephemeral container to debug running Java applications.

## Features

- **Eclipse Temurin 25 JDK** - Full JDK with diagnostic tools (jcmd, jstack, jmap, jfr, etc.)
- **Runs as UID 2000** - Matches standard HMPPS application containers

## Usage

### As an Ephemeral Container

```bash
kubectl debug -it <pod-name> --image=ghcr.io/ministryofjustice/hmpps-jdk-debug:latest --target=<container-name>
```

### Common Debugging Commands

```bash
# List Java processes
jps -l

# Thread dump
jstack <pid>

# Heap dump
jmap -dump:format=b,file=/tmp/heap.hprof <pid>

# JVM diagnostics
jcmd <pid> VM.info
jcmd <pid> GC.heap_info
jcmd <pid> Thread.print

# Start a flight recording
jcmd <pid> JFR.start duration=60s filename=/tmp/recording.jfr
```
