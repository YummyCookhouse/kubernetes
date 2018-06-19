## 什么是Flannel
> Flannel为kubernetes提供overlay network以实现跨节点的容器间的访问

## 运行(首先，确保你的ETCD cluster已经正确运行)
```sh
#1. 保存flannel network配置到ETCD
curl -XPUT http://127.0.0.1:2379/v2/keys/k8s/config -d value="{\"Network\": \"192.168.0.0/16\"}"

#2. 启动一个DIND集群, 每个集群节点都运行了flanneld
docker-compose -f flannel/docker-compose.yml up --build -d
```

## 验证
```sh
#1. 在flannel0节点启动一个centos7
docker exec -it flannel0 bash
docker run -it --rm centos:7 bash
#2. 获取flannel0内运行的container的ip
yum install net-tools -y 
ifconfig eth0| grep 'inet '
```
```sh
#3. 在flannel1节点启动一个centos7
docker exec -it flannel0 bash
docker run -it --rm centos:7 bash
#4. ping第二步获得的IP
ping X.X.X.X
#5. kill掉flanneld进程然后重新ping X.X.X.X则无法通信
```

## 原理
![image](http://docker-k8s-lab.readthedocs.io/en/latest/_images/docker-flannel.png)