#!/bin/bash
set -e

sed -i "s/PFTPD_MYSQL_SERVER/$MYSQL_SERVER/g" /etc/pure-ftpd/db/mysql.conf
sed -i "s/PFTPD_MYSQL_PORT/$MYSQL_PORT/g" /etc/pure-ftpd/db/mysql.conf
sed -i "s/PFTPD_MYSQL_USER/$MYSQL_USER/g" /etc/pure-ftpd/db/mysql.conf
sed -i "s/PFTPD_MYSQL_PASSWORD/$MYSQL_PASSWORD/g" /etc/pure-ftpd/db/mysql.conf
sed -i "s/PFTPD_MYSQL_DATABASE/$MYSQL_DATABASE/g" /etc/pure-ftpd/db/mysql.conf

echo "$CERTIFICATE" > /etc/ssl/private/pure-ftpd.pem
awk '{gsub(/\\n/,RS)}1' /etc/ssl/private/pure-ftpd.pem > /etc/ssl/private/pure-ftpd.pem2
mv /etc/ssl/private/pure-ftpd.pem2 /etc/ssl/private/pure-ftpd.pem

/usr/sbin/pure-ftpd-mysql -l mysql:/etc/pure-ftpd/db/mysql.conf -A -j -8 UTF-8 -u 33 -E -Y 2 -p 30000:30009 -P $EXTERNALIP