#!/bin/bash

#create by zongqing
#Handler_read_next	unit:rows 	Description:The number of requests to read the next row in key order. This value is incremented if you are querying an index column with a range constraint or if you are doing an index scan.
#Handler_read_rnd	unit:rows	Description:stat shows that we are not using indexes and accessing the table in random order
#Handler_read_rnd_next	unit:rows	Description:even worse paging through the table in random order



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Handler_read"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	unit: rows,requests,operations"

	echo "next.type	DERIVE"
	echo "next.min	0"
	echo "next.draw	LINE2"
	echo "next.label	next"

	echo "rnd.type	DERIVE"
	echo "rnd.min	0"
	echo "rnd.draw	LINE2"
	echo "rnd.label	rnd"

	echo "rnd_next.type	DERIVE"
	echo "rnd_next.min	0"
	echo "rnd_next.draw	LINE2"
	echo "rnd_next.label	rnd_next"

	echo "first.type	DERIVE"
	echo "first.min	0"
	echo "first.draw	LINE2"
	echo "first.label	first"

	echo "key.type	DERIVE"
	echo "key.min	0"
	echo "key.draw	LINE2"
	echo "key.label	key"

	echo "prev.type	DERIVE"
	echo "prev.min	0"
	echo "prev.draw	LINE2"
	echo "prev.label	prev"
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Handler_read_next=`$MYSQLADMIN | grep "Handler_read_next " | awk '{print $4}'`
	Handler_read_rnd=`$MYSQLADMIN | grep "Handler_read_rnd " | awk '{print $4}'`
	Handler_read_rnd_next=`$MYSQLADMIN | grep "Handler_read_rnd_next " | awk '{print $4}'`
	Handler_read_key=`$MYSQLADMIN | grep "Handler_read_key " | awk '{print $4}'`
	Handler_read_prev=`$MYSQLADMIN | grep "Handler_read_prev " | awk '{print $4}'`
	Handler_read_first=`$MYSQLADMIN | grep "Handler_read_first " | awk '{print $4}'`

	echo "next.value	${Handler_read_next}"
	echo "rnd.value	${Handler_read_rnd}"
	echo "rnd_next.value	${Handler_read_rnd_next}"
	echo "key.value	${Handler_read_key}"
	echo "first.value	${Handler_read_first}"
	echo "prev.value	${Handler_read_prev}"
fi