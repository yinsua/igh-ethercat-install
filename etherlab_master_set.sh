#/bin/bash

export ETHERLAB_PREFIX="/opt/etherlab"
set -ex \
&& modprobe ec_master \
&& $ETHERLAB_PREFIX/etc/init.d/ethercat start \
&& echo KERNEL==\"EtherCAT[0-9]\", MODE=\"0777\" | tee -a /etc/udev/rules.d/99-ethercat.rules \
&& udevadm control --reload-rules \
&& echo $ETHERLAB_PREFIX/lib | tee -a /etc/ld.so.conf \
&& ldconfig \
&& echo `echo $USER` hard rtprio 99 | tee -a /etc/security/limits.conf
