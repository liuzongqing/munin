#!/bin/bash

#create by zongqing
#Innodb_buffer_pool_pages_dirty	unit: pages Description:The number of pages currently dirty
#Innodb_buffer_pool_pages_free 	unit: pages Description:The number of free pages 
#Innodb_buffer_pool_pages_data 	unit: pages Description:The number of pages containing data (dirty or clean)
#Innodb_buffer_pool_pages_total	unit: pages Description:The total size of the buffer pool, in pages.
#Innodb_buffer_pool_pages_flushed unit:pages Description:The number of pages flushed

#By default every page size=16kB



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Innodb_Pool_Pages"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	pages(every pages size=16KB)"

	echo "total.type	GAUGE"
	echo "total.min	0"
	echo "total.draw	AREA"
	echo "total.label	total"

	echo "free.type	GAUGE"
	echo "free.min	0"
	echo "free.draw	AREA"
	echo "free.label	free"

	echo "dirty.type	GAUGE"
	echo "dirty.min	0"
	echo "dirty.draw	AREA"
	echo "dirty.label	dirty"

	echo "data.type	GAUGE"
	echo "data.min	0"
	echo "data.draw	AREA"
	echo "data.label	data"

	echo "flushed.type	DERIVE"
	echo "flushed.min 0"
	echo "flushed.draw LINE2"
	echo "flushed.label flushed(per sec)"
	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Pages_total=`$MYSQLADMIN | grep "Innodb_buffer_pool_pages_total " | awk '{print $4}'`
	Pages_free=`$MYSQLADMIN | grep "Innodb_buffer_pool_pages_free " | awk '{print $4}'`
	Pages_dirty=`$MYSQLADMIN | grep "Innodb_buffer_pool_pages_dirty " | awk '{print $4}'`
	Pages_data=`$MYSQLADMIN | grep "Innodb_buffer_pool_pages_data " | awk '{print $4}'`
	Pages_flushed=`$MYSQLADMIN | grep "Innodb_buffer_pool_pages_flushed " | awk '{print $4}'`

	echo "total.value	${Pages_total}"
	echo "dirty.value	${Pages_dirty}"
	echo "free.value	${Pages_free}"
	echo "data.value	${Pages_data}"
	echo "flushed.value	${Pages_flushed}"
fi