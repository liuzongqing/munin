#!/bin/bash

#create by zongqing
#Innodb_row_lock_time	unit: milliseconds 	Des:The total time spent in acquiring row locks, in milliseconds. Added in MySQL 5.0.3.
#Innodb_row_lock_waits	unit: times 		Des:The number of times a row lock had to be waited for. Added in MySQL 5.0.3.


if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Mysql_Lock"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	innodb row lock"

	echo "time.type	DERIVE"
	echo "time.min	0"
	echo "time.draw	LINE2"
	echo "time.label	time(milliseconds)"

	echo "waits.type	DERIVE"
	echo "waits.min	0"
	echo "waits.draw	LINE2"
	echo "waits.label	waits(times)"

	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Time=`$MYSQLADMIN | grep "Innodb_row_lock_time " | awk '{print $4}'`
	Wait=`$MYSQLADMIN | grep "Innodb_row_lock_waits " | awk '{print $4}'`

	echo "time.value	${Time}"
	echo "waits.value	${Wait}"
fi