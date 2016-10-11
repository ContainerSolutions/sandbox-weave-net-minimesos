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

When you run this a Mesos container is started but a network cannot be created:

```
mesos-execute --networks=weave --resources='cpus:1;mem:265' --name=webserver --command='while true ; do  echo -e "HTTP/1.1 200 OK\n\n $(date)" | nc -l -p 1500  ; done' --master=172.17.0.4:5050            
WARNING: Logging before InitGoogleLogging() is written to STDERR
I1011 15:40:19.334565 28012 process.cpp:1067] libprocess is initialized on 172.17.0.5:45629 with 8 worker threads
I1011 15:40:19.335000 28012 logging.cpp:194] INFO level logging started!
I1011 15:40:19.335279 28012 logging.cpp:199] Logging to /var/log
I1011 15:40:19.335300 28012 scheduler.cpp:172] Version: 1.0.0
I1011 15:40:19.346253 28020 scheduler.cpp:461] New master detected at master@172.17.0.4:5050
I1011 15:40:19.347072 28020 scheduler.cpp:470] Waiting for 8.088737ms before initiating a re-(connection) attempt with the master
I1011 15:40:19.356988 28013 scheduler.cpp:349] Connected with the master at http://172.17.0.4:5050/master/api/v1/scheduler
I1011 15:40:19.357347 28013 scheduler.cpp:231] Sending SUBSCRIBE call to http://172.17.0.4:5050/master/api/v1/scheduler
I1011 15:40:19.362673 28019 scheduler.cpp:662] Enqueuing event SUBSCRIBED received from http://172.17.0.4:5050/master/api/v1/scheduler
I1011 15:40:19.362906 28019 scheduler.cpp:662] Enqueuing event HEARTBEAT received from http://172.17.0.4:5050/master/api/v1/scheduler
Subscribed with ID 'acb1d4ad-4884-4253-961c-d3eea513da62-0001'
I1011 15:40:19.363189 28016 scheduler.cpp:662] Enqueuing event OFFERS received from http://172.17.0.4:5050/master/api/v1/scheduler
I1011 15:40:19.363476 28013 resources.cpp:574] Parsing resources as JSON failed: cpus:1;mem:265
Trying semicolon-delimited string format instead
Submitted task 'webserver' to agent 'acb1d4ad-4884-4253-961c-d3eea513da62-S0'
I1011 15:40:19.364065 28015 scheduler.cpp:231] Sending ACCEPT call to http://172.17.0.4:5050/master/api/v1/scheduler
I1011 15:40:19.667718 28015 scheduler.cpp:662] Enqueuing event UPDATE received from http://172.17.0.4:5050/master/api/v1/scheduler
Received status update TASK_FAILED for task 'webserver'
  message: 'Failed to launch container: Collect failed: The CNI plugin 'weave-net' failed to attach container e3cebaaa-d7e6-4487-a58e-75734478452d to CNI network 'weave': {
    "code": 100,
    "msg": "Failed to get netdev for \"weave\" bridge: Link not found"
}; Abnormal executor termination'
  source: SOURCE_AGENT
  reason: REASON_CONTAINER_LAUNCH_FAILED
I1011 15:40:19.668148 28014 scheduler.cpp:231] Sending ACKNOWLEDGE call to http://172.17.0.4:5050/master/api/v1/scheduler
```

The problem here is that there is no weave bridge and when creating it inside the container nsenter is missing. 

```
$ ./weave --local create-bridge
ERROR: nsenter utility missing. Please install it.
root@92caf5e095f6:/script# apt-get install nsenter
```

# Links

* [Make it easier to run weave dockerless](https://github.com/weaveworks/weave/issues/1566)
* [Running nsenter on Ubuntu 14.04](http://askubuntu.com/questions/439056/why-there-is-no-nsenter-in-util-linux)

# Contact

Feel free to contact me on Twitter at @Frank_Scholten
