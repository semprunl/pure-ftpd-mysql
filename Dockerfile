FROM kauden/pure-ftpd-mysql

ENV MYSQL_SERVER
ENV MYSQL_USER
ENV MYSQL_PASSWORD
ENV MYSQL_DATABASE
ENV MYSQL_PORT
ENV CERTIFICATE

RUN apt-mark hold pure-ftpd pure-ftpd-common

ADD mysql.conf /etc/pure-ftpd/db/mysql.conf

RUN sed -i "s/PFTPD_MYSQL_SERVER/$MYSQL_SERVER/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_PORT/$MYSQL_PORT/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_USER/$MYSQL_USER/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_DATABASE/$MYSQL_DATABASE/g" /etc/pure-ftpd/db/mysql.conf

RUN echo "$CERTIFICATE" >> /etc/ssl/private/pure-ftpd.pem

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22
CMD ["/run.sh"]