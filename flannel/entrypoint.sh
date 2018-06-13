#!/usr/bin/env bash

echo "-----------starting flannel agent-------------"
flanneld -etcd-endpoints=$ETCD_ENDPOINTS -etcd-prefix=$ETCD_PREFIX -ip-masq=true &
sleep 5
echo "-----------subnet allocated by flannel allocated--------"
cat /run/flannel/subnet.env
source /run/flannel/subnet.env
echo "-----------flannel bridge network info--------"
ip a | grep flannel0 | grep inet
sleep 3
echo "-----------starting docker daemon---------"
dockerd -D --bip=$FLANNEL_SUBNET --mtu=$FLANNEL_MTU --ip-masq=false