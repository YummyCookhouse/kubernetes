FROM flannel-docker-node

ENV container docker
RUN ["yum", "install", "kubernetes-node", "-y"]

COPY ./entrypoint.sh /
CMD ["./entrypoint.sh"]