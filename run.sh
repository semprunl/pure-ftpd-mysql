#!/bin/bash

/entrypoint.sh

/usr/sbin/pure-ftpd-mysql -l mysql:/etc/pure-ftpd/db/mysql.conf -A -j -8 UTF-8 -u 33 -E -Y 2 -p 30000:30009 -P $EXTERNALIP