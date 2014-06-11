# CloudStack 4.3 Management Server installation
# VERSION	0.1

FROM ubuntu:12.04
MAINTAINER star76 "mirorin@cloudstackers.net"

# initial settings
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'root:<PASSWORD>' | chpasswd
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

# preparing repository
ADD cloudstack.list /etc/apt/sources.list.d/
RUN apt-get update

# settings for supervisord
RUN apt-get install -y openssh-server mysql-server supervisor net-tools
RUN mkdir /var/run/sshd/
RUN mkdir -p /var/log/supervisor/
RUN mkdir -p /etc/supervisor/conf.d/
ADD supervisord.conf /etc/supervisor/conf.d/

# mysql configuration
ADD my.cnf /etc/mysql/
RUN (/usr/bin/mysqld_safe &); sleep 5; echo "DELETE FROM mysql.user WHERE host='::1';SET PASSWORD FOR root@localhost = PASSWORD('<PASSWORD>'); GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<PASSWORD>' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -uroot

# CloudStack installation
RUN apt-get install -y --force-yes cloudstack-management
RUN wget http://launchpadlibrarian.net/88151258/tomcat6_6.0.33-1_all.deb
RUN wget http://launchpadlibrarian.net/88151257/tomcat6-common_6.0.33-1_all.deb
RUN wget http://launchpadlibrarian.net/88151260/libtomcat6-java_6.0.33-1_all.deb
RUN dpkg -i tomcat6-common_6.0.33-1_all.deb
RUN dpkg -i tomcat6_6.0.33-1_all.deb
RUN dpkg -i libtomcat6-java_6.0.33-1_all.deb

# port expose
EXPOSE 22
EXPOSE 3306

# CMD execution
CMD "/usr/bin/supervisord"
