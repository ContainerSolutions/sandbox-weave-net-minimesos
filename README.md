# Sandbox Weave Net Minimesos

# Background

The goal of this repo is to experiment with running Weave Net inside of minimesos. This repo contains a Dockerfile for a custom minimesos image and a minimesosFile that uses this image.

# How to run

```
$ cd docker; ./build.sh
$ cd ..; minimesos up
$ docker ps -a
$ docker run -it $MINIMESOS_AGENT_CONTAINER_ID sh
(Inside minimesos agent container)
# Run the contents of runtask.sh using the IP of the minimesos master   
```

When you run this a Mesos container is started but a network cannot be created because the weave router is not available:

```
Received status update TASK_FAILED for task 'webserver'
  message: 'Failed to launch container: Collect failed: The CNI plugin 'weave-net' failed to attach container ed9f349f-964e-4eeb-80e6-3fec87be3a24 to CNI network 'weave': {
    "code": 100,
    "msg": "unable to allocate IP address: Post http://127.0.0.1:6784/ip/ed9f349f-964e-4eeb-80e6-3fec87be3a24: dial tcp 127.0.0.1:6784: getsockopt: connection refused"
}; Abnormal executor termination'
  source: SOURCE_AGENT
  reason: REASON_CONTAINER_LAUNCH_FAILED
I1006 15:36:29.209211 22499 scheduler.cpp:231] Sending ACKNOWLEDGE call to http://172.17.0.4:5050/master/api/v1/scheduler
```

# Contact

Feel free to contact me on Twitter at @Frank_Scholten
