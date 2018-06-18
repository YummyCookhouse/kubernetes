FROM centos:7
RUN ["yum", "install", "flannel", "-y"]
RUN ["yum", "install", "docker", "-y"]
RUN ["yum", "install", "iptables", "-y"]
RUN ["yum", "install", "iproute", "-y"]
RUN ["yum", "install", "bind-utils", "-y"]

# KENG see https://stackoverflow.com/questions/42754779/docker-runc-not-installed-on-system!!!!!!
RUN ln -s /usr/libexec/docker/docker-runc-current /usr/bin/docker-runc

RUN echo net.bridge.bridge-nf-call-iptables=1 >> /etc/sysctl.conf
RUN echo net.bridge.bridge-nf-call-ip6tables=1 >> /etc/sysctl.conf

# KENG (storage type issue) !!!!!!
VOLUME /var/lib/docker
COPY ./entrypoint.sh /
CMD ["./entrypoint.sh"]