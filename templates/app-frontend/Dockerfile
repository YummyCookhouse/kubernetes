FROM centos:7
RUN yum install epel-release -y
RUN yum install nginx -y

COPY ./entrypoint.sh /

CMD ["./entrypoint.sh"]