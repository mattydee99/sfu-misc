#!/bin/bash
printerName='SFU_Print'

lpstat -p $printerName &> /dev/null
if [ `echo $?` = 0 ]; then
  /usr/sbin/lpadmin -x $printerName
fi
exit 0
