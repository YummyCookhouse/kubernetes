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
echo "-----------starting kubelet------------"
sleep 3
# --pod-infra-container-image KENG see https://github.com/kubernetes/kubernetes/issues/7090!!!!!!
kubelet --pod-infra-container-image=registry.aliyuncs.com/archon/pause-amd64:3.0 --api-servers=http://kube-master:8080 --node-labels=$NODE_LABELS --hostname-override=$NODE_NAME &
echo "-----------starting kube-proxy------------"
sleep 3

## --conntrack-max-per-core another KENG (DIND doesn't have permission to update conntrack to file)--##
## --proxy-mode=userspace another KENG (ensure you can access service from node otherwise you can only access service from pod) see https://ieevee.com/tech/2017/01/20/k8s-service.html
kube-proxy --conntrack-max-per-core=0 --master=http://kube-master:8080 --cluster-cidr=192.168.0.0/16 --proxy-mode=userspace