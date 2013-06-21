#!/bin/bash

#create by zongqing
#Innodb_pages_created	unit: pages
#Innodb_pages_reade 	unit: pages
#Innodb_pages_written 	unit: pages



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Innodb_Pages"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	Innodb pages created, read(-) / written(+)"

	echo "read.type	DERIVE"
	echo "read.min	0"
	echo "read.draw	LINE2"
	echo "read.label	read/written"
	echo "read.graph no"
	echo "written.type	DERIVE"
	echo "written.min	0"
	echo "written.draw	LINE2"
	echo "written.label	read/written"
	echo "written.negative	read"
	echo "created.type	DERIVE"
	echo "created.label	created"
	echo "created.min 0"
	echo "created.draw	LINE2"
	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Pages_read=`$MYSQLADMIN | grep "Innodb_pages_read " | awk '{print $4}'`
	Pages_written=`$MYSQLADMIN | grep "Innodb_pages_written " | awk '{print $4}'`
	Pages_created=`$MYSQLADMIN | grep "Innodb_pages_created " | awk '{print $4}'`

	echo "read.value	${Pages_read}"
	echo "written.value	${Pages_written}"
	echo "created.value	${Pages_created}"
fi