## 运行
```sh
docker-compose -f kube-master/docker-compose.yml up --build -d
```

## 验证
```sh
docker exec -it kube-master bash
kubectl get nodes
```

## 核心组件
- kube-apiserver  
- kube-scheduler
- kube-controller-manager

![image](/kube-master/assets/master-components.png)

## References
- [Kubernetes Master Components](https://medium.com/jorgeacetozi/kubernetes-master-components-etcd-api-server-controller-manager-and-scheduler-3a0179fc8186)