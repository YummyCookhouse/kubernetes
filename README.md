# 关于项目
> 虽然现在有很多工具可以帮助你在开发环境快速部署一个k8s集群(如: kubeadmin, minikube等)，但是这些工具帮你做了太多工作会致使你忽略一些k8s的关键内容，在这个repo的帮助下，你可以尝试一步步`create a k8s cluster from scratch`
> 这样你可以更好的理解k8s中的一些概念.

# Kubernetes
### k8s是个什么玩意儿?
> k8s是容器(如docker)集群管理系统, 相比直接使用docker, k8s可以帮你:
- 你可以设置你的容器集群的规模. 并且可以在任意时刻scale in和scale out. (和ASG很像哈)
- 重启容器, 当容器挂掉的时候. k8s会尝试重启或者生成新的容器, 来保证容器的规模. (和ASG很像哈)
- 跨节点的容器相互间的访问. 一台机器上的docker container可以相互访问(通过link), 但是跨机器的就比较麻烦了
- 容器的均衡负载
- `0 down time`更新你的应用

如果你用过AWS, 你会觉得k8s提供的功能和ASG,ELB这几个组件的功能很相似. 但是k8s是容器级别的调度而ASG是虚拟机级别的调度。

### 核心概念
- Node
    > 集群中真正运行容器的节点，可以是虚机也可以是物理机. Node的核心组件有:
    > - kubelet
      - kube-proxy
- Master
    > 集群中的脑, 负责处理API调用, 部署容器到工作节点, 调节集群规模等工作. 运行在Master的核心组件有:
    > - kube-apiserver
      - kube-scheduler
      - kube-controller-manager
- Container
    > docker或者rocket容器 
- Pod
    > k8s部署的最小单位，包含一组容器和一个卷, Pod在生成的时候会被随机分配一个IP, Pod内部的容器共享一个网络空间。
- Label
    > 资源标示, 你可以通过Label去过滤资源. 类似AWS的tag
- Replication Controller
- Overlay network
- VIP
- Service
- Namespace

# 准备工作
> 项目内所有的package都已经dockerize了，所以，你只需要一件东西，就是Docker

# 一步一步来
 - [运行ETCD集群](https://github.com/YummyCookhouse/kubernetes/blob/master/etcd/README.md)
 - [用flannel作为集群的overlay network](https://github.com/YummyCookhouse/kubernetes/blob/master/flannel/README.md)
 - 创建一个仅包含master节点的k8s集群
 - 创建2个node节点并加入到k8s集群
 - 使用`kubectl`部署应用
 - 使用`yaml`部署应用
 - 创建`Service`
 - 集群内的DNS