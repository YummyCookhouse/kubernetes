FROM flannel-docker-node

ENV container docker
RUN ["yum", "install", "kubernetes-master", "-y"]

COPY ./entrypoint.sh /
CMD ["./entrypoint.sh"]