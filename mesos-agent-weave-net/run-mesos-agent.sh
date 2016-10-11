#!/usr/bin/env bash

WEAVE_DEBUG=1 /script/weaver --name 82:e6:9e:fc:9d:af --nickname agent0 --http-addr=127.0.0.1:6784 --ipalloc-range=10.32.0.0/12 --ipalloc-init consensus=1 >weaver.log 2>&1 &

/usr/sbin/mesos-agent --isolation=filesystem/linux,docker/runtime --image_providers=docker --network_cni_plugins_dir=/opt/cni/bin --network_cni_config_dir=/etc/cni/net.d --no-hostname_lookup $@ output.log
