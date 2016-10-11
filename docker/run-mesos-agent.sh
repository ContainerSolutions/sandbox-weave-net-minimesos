#!/usr/bin/env bash

/script/weaver --name 82:e6:9e:fc:9d:af --nickname agent0 &

/usr/sbin/mesos-agent --isolation=filesystem/linux,docker/runtime --image_providers=docker --network_cni_plugins_dir=/opt/cni/bin --network_cni_config_dir=/etc/cni/net.d --no-hostname_lookup $@ output.log
