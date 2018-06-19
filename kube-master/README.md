## 核心组件
- kube-apiserver
- kube-scheduler
- kube-controller-manager

## 运行
```sh
docker-compose -f kube-master/docker-compose.yml up --build -d
```

## 验证
```sh
docker exec -it kube-master bash
kubectl get nodes
```