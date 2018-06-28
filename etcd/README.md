## 什么是ETCD?
> A highly-available key value store for shared configuration and service discovery.

## ETCD的应用场景
- 存储配置
- [选举](https://github.com/YummyCookhouse/ETCD/tree/master/election-and-discovery)
- [发现](https://github.com/YummyCookhouse/ETCD/tree/master/election-and-discovery)
- 订阅与发布
- [分布式锁](https://github.com/YummyCookhouse/ETCD/tree/master/lock)
- 分布式队列

## ETCD vs ZooKeeper
- ETCD的运行维护更简洁
- ETCD基于[Raft](http://thesecretlivesofdata.com/raft/)共识算法, ZooKeeper基于Paxos共识算法。Raft更简单易于理解
- ETCD提供Restful API接口
- ETCD支持SSL客户端认证
 
## ETCD & k8s
> kubernetes master用ETCD作为配置和集群数据的data store. 如果你使用flannel作为kubernetes的overlay network, 那么ETCD用于存储flannel的配置

## 启动ETCD集群
```sh
docker-compose -f etcd/docker-compose.yml up
```

## 验证
```sh
#保存配置
curl -XPUT http://127.0.0.1:2379/v2/keys/myapp/config -d value="{\"cacheSize\": 1024}"
#获取配置
curl http://127.0.0.1:2379/v2/keys/myapp/config
#删除配置
curl -XDELETE http://127.0.0.1:2379/v2/keys/myapp/config?dir=true&recursive=true
```

## 引用
- [ETCD官方文档](https://github.com/coreos/etcd/blob/master/Documentation/docs.md)
- [Raft共识算法动画示例(推荐)](http://thesecretlivesofdata.com/raft/)