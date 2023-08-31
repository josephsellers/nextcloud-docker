#!/bin/bash
GID=`stat -c "%g" /dev/dri/renderD128`
#groupadd -g $GID render2 || true # sometimes this is needed
GROUP=`getent group $GID | cut -d: -f1`
usermod -aG $GROUP www-data

apache2-foreground
