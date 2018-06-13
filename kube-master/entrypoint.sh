#!/usr/bin/env bash

echo "-----------starting flannel agent-------------"
flanneld -etcd-endpoints=$ETCD_ENDPOINTS -etcd-prefix=$ETCD_PREFIX -ip-masq=true &
echo "-----------subnet allocated by flannel allocated--------"
sleep 5
cat /run/flannel/subnet.env
source /run/flannel/subnet.env
echo "-----------flannel bridge network info--------"
ip a | grep flannel0 | grep inet
echo "-----------starting docker daemon---------"
sleep 3
dockerd -D --bip=$FLANNEL_SUBNET --mtu=$FLANNEL_MTU --ip-masq=false &
echo "-----------starting apiserver----------"

sleep 3
kube-apiserver --insecure-bind-address=0.0.0.0 --insecure-port=8080 --service-cluster-ip-range=192.168.0.0/16 --etcd-servers=http://etcd0:2379,http://etcd1:2379 &
echo "-----------starting scheduler----------"
sleep 5
kube-scheduler --master=0.0.0.0:8080 &
echo "-----------starting controller manager----------"
sleep 5
kube-controller-manager --master=0.0.0.0:8080