#!/bin/bash

#create by zongqing
#Innodb_os_log_fsyncs			unit: numbers
#Innodb_os_log_pending_fsyncs 	unit: numbers
#Innodb_os_log_pending_writes 	unit: numbers
#Innodb_os_log_written			unit: bytes



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Innodb_os_log"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	os_log fsyncs(number),written(MB)"

	echo "fsyncs.type	DERIVE"
	echo "fsyncs.min	0"
	echo "fsyncs.draw	LINE2"
	echo "fsyncs.label	fsyncs(numbers)"

	echo "written.type	DERIVE"
	echo "written.min	0"
	echo "written.draw	LINE2"
	echo "written.label	written(MBytes)"

	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Fsyncs=`$MYSQLADMIN | grep "Innodb_os_log_fsyncs " | awk '{print $4}'`
	Written=`$MYSQLADMIN | grep "Innodb_os_log_written " | awk '{printf "%.2lf", $4/1024/1024}'`

	echo "fsyncs.value	${Fsyncs}"
	echo "written.value	${Written}"
fi