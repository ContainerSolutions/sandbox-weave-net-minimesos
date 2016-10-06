#!/usr/bin/env bash

mesos-execute --networks=weave --resources='cpus:1;mem:265' --name=webserver --command='while true ; do  echo -e "HTTP/1.1 200 OK\n\n $(date)" | nc -l -p 1500  ; done' --master=$MINIMESOS_MASTER
