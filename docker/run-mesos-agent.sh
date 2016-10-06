#!/usr/bin/env bash

weaver --port 6784 --name 82:e6:9e:fc:9d:af --nickname franktop --datapath datapath --ipalloc-range 10.32.0.0/12 --dns-effective-listen-address 127.0.0.1 --dns-listen-address 127.0.0.1:53 --http-addr 127.0.0.1:6784 --resolv-conf /var/run/weave/etc/resolv.conf &

/usr/sbin/mesos-agent --isolation=filesystem/linux,docker/runtime --image_providers=docker --network_cni_plugins_dir=/opt/cni/bin --network_cni_config_dir=/etc/cni/net.d --no-hostname_lookup $@ output.log
