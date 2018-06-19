# 核心组件
- kubelet
- kube-proxy

# 运行(host)
```sh
docker-compose -f kube-node/docker-compose.yml up --build -d
docker cp templates kube-master:/
```

# 查看node
```sh
#1. 进入kube-master container(host)
docker exec -it kube-master bash
#2 查看node状态(master)
kubectl get nodes
```

# 使用kubectl部署应用(master)
```sh
#1. 在2个node状态ready之后用kubectl部署应用
kubectl run webapp --image=stardustdocker/nginx --port=80 --replicas=3
#2. 查看pods
kubectl get pods --output=wide
#3. 查看pod的详细信息
kubectl describe ${POD的ID}
#4. 访问webapp
curl -L http://${POD的ID}
```

# 移除应用(master)
```sh
kubectl delete deployment webapp
```

# 使用yaml重新部署webapp(master)
```sh
kubectl create -f templates/app-frontend/nginx-deployment.yml
kubectl get pods --output=wide
```

# 创建Service(master)
```sh
#1. 方法1 通过kubectl创建
kubectl expose deployment/webapp --port=80 --target-port=80 --type=LoadBalancer --name=webapp-lb
#2. 方法2 通过yaml创建
kubectl create -f templates/app-frontend/nginx-svc.yml
#3. 查看service
kubectl get services --output=wide
```

# 在集群内部通过Service来访问webapp
```sh
#1. 进入node节点 (host)
docker exec -it kube-node1 bash
#2. 访问service (node)
curl -L http://${service的clusterIP}
#3. 从node进入webapp容器内部 (node)
docker exec -it ${POD_ID} bash
#4. 访问service (pod)
curl -L http://${service的clusterIP}
```

# 在集群外部通过service来访问webapp(host)
```sh
curl -L http://${你机器的IP}:8080/api/v1/proxy/namespaces/default/services/webapp-lb:80
```

# 创建DNS
```sh
#1. 创建DNS pod (master)
kubectl create -f templates/kube-dns/kube-dns-deployement.yml
kubectl get pods --output=wide
#2. 创建DNS service (master)
kubectl create -f templates/kube-dns/kube-dns-svc.yml
kubectl get services --output=wide
#4. 进入node节点 (host)
docker exec -it kube-node1 bash
#5. 进入到POD
docker exec -it ${POD的ID} bash
#6. 在POD内部使用域名访问
curl -L http://webapp.default.svc.local.cluster
```

# Scale你的应用
> 将templates/app-frontend/nginx-deployment.yml中的replicas增加/减少
```bash
# 1. 更新templates到master (host)
docker cp templates kube-master:/
# 2. 进入kube-master (host)
docker exec -it kube-master bash
# 3. scale webapp
kubectl replace -f templates/app-frontend/nginx-deployment.yml
kubectl get pods --output=wide
```

# 更新你的应用
> 将templates/app-frontend/nginx-deployment.yml中的image从`stardustdocker/nginx`改到`nginx`
```bash
# 1. 更新templates到master (host)
docker cp templates kube-master:/
# 2. 进入kube-master (host)
docker exec -it kube-master bash
# 3. 更新webapp (master)
kubectl replace -f templates/app-frontend/nginx-deployment.yml
kubectl get pods --output=wide
```