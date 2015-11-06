FROM kauden/pure-ftpd-mysql

RUN apt-mark hold pure-ftpd pure-ftpd-common

ADD mysql.conf /etc/pure-ftpd/db/mysql.conf

RUN sed -i "s/PFTPD_MYSQL_SERVER/$MYSQL_SERVER/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_PORT/$MYSQL_PORT/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_USER/$MYSQL_USER/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" /etc/pure-ftpd/db/mysql.conf
RUN sed -i "s/PFTPD_MYSQL_DATABASE/$MYSQL_DATABASE/g" /etc/pure-ftpd/db/mysql.conf]

RUN echo "$CERTIFICATE" >> /etc/ssl/private/pure-ftpd.pem