#!/bin/bash

#create by zongqing
#innodb_buffer_pool_read_requests:从缓冲池中读取页的次数 
#innodb_data_read:总共读入的字节数 
#innodb_data_reads:发起读取请求的次数，每次读取可能需要读多少个页 
#缓冲池命中率=innodb_buffer_pool_read_requests/(innodb_buffer_pool_read_requests+innodb_buffer_pool_read_ahead+ innodb_buffer_pool_reads) 
#平均每次读取的字节数=innodb_data_read/innodb_data_reads

#Innodb_data_fsyncs             #the total number of data fsynces from buffer to disk
#Innodb_data_pending_fsyncs		#the current number of data fsyncs
#Innodb_data_pending_reads		#the current number of data reads
#Innodb_data_pending_writes		#the current number of data writes
#Innodb_data_read 				#the total size of data reads
#Innodb_data_reads 				#the total number of data reads
#Innodb_data_writes 			#
#Innodb_data_written			#



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Innodb_data_opertions"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	the number of data operates"

	echo "reads.type	DERIVE"
	echo "reads.min	0"
	echo "reads.draw	LINE2"
	echo "reads.label	aver_reads/writes"
	echo "reads.graph 	no"

	echo "writes.type	DERIVE"
	echo "writes.min	0"
	echo "writes.draw	LINE2"
	echo "writes.label	aver_reads/writes"
	echo "writes.negative reads"	

	echo "pending_reads.type	GAUGE"
	echo "pending_reads.min	0"
	echo "pending_reads.draw	LINE2"
	echo "pending_reads.label	curr_reads/writes"
	echo "pending_reads.graph 	no"

	echo "pending_writes.type	GAUGE"
	echo "pending_writes.min	0"
	echo "pending_writes.draw	LINE2"
	echo "pending_writes.label	curr_reads/writes"
	echo "pending_writes.negative pending_reads"

	echo "fsyncs.type	DERIVE"
	echo "fsyncs.min	0"
	echo "fsyncs.draw	LINE2"
	echo "fsyncs.label	aver_fsyncs"

	echo "pending_fsyncs.type	GAUGE"
	echo "pending_fsyncs.min	0"
	echo "pending_fsyncs.draw	LINE2"
	echo "pending_fsyncs.label	curr_fsyncs"

else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Innodb_data_fsyncs=`$MYSQLADMIN | grep "Innodb_data_fsyncs " | awk '{print $4}'`
	Innodb_data_reads=`$MYSQLADMIN | grep "Innodb_data_reads " | awk '{print $4}'`
	Innodb_data_writes=`$MYSQLADMIN | grep "Innodb_data_writes " | awk '{print $4}'`
	Innodb_data_pending_fsyncs=`$MYSQLADMIN | grep "Innodb_data_pending_fsyncs " | awk '{print $4}'`
	Innodb_data_pending_reads=`$MYSQLADMIN | grep "Innodb_data_pending_reads " | awk '{print $4}'`
	Innodb_data_pending_writes=`$MYSQLADMIN | grep "Innodb_data_pending_writes " | awk '{print $4}'`

	echo "fsyncs.value	${Innodb_data_fsyncs}"
	echo "reads.value	${Innodb_data_reads}"
	echo "writes.value	${Innodb_data_writes}"
	echo "pending_fsyncs.value	${Innodb_data_pending_fsyncs}"
	echo "pending_reads.value	${Innodb_data_pending_reads}"
	echo "pending_writes.value	${Innodb_data_pending_writes}"
fi