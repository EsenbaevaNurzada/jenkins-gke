FROM amazonlinux

RUN yum -y update
RUN yum -y install httpd

COPY ./htmls   /var/www/html/


CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
EXPOSE 80