#!/bin/bash

#create by zongqing
#Handler_read_next	unit:rows 	Description:The number of requests to read the next row in key order. This value is incremented if you are querying an index column with a range constraint or if you are doing an index scan.
#Handler_read_rnd	unit:rows	Description:stat shows that we are not using indexes and accessing the table in random order
#Handler_read_rnd_next	unit:rows	Description:even worse paging through the table in random order



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Buffer_pool_requests"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	Innodb buffer pool read(-) / write(+)"

	echo "read.type	DERIVE"
	echo "read.min	0"
	echo "read.draw	LINE2"
	echo "read.label	requests"
	echo "read.graph no"
	echo "write.type	DERIVE"
	echo "write.min	0"
	echo "write.draw	LINE2"
	echo "write.label	requests"
	echo "write.negative	read"
	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Buffer_read=`$MYSQLADMIN | grep "Innodb_buffer_pool_read_requests " | awk '{print $4}'`
	Buffer_write=`$MYSQLADMIN | grep "Innodb_buffer_pool_write_requests " | awk '{print $4}'`

	echo "read.value	${Buffer_read}"
	echo "write.value	${Buffer_write}"
fi