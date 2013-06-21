#!/bin/bash

#create by zongqing
#Sort_merge_passes	unit: merge passes 	Des:The number of merge passes that the sort algorithm has had to do. If this value is large, you should consider increasing the value of the sort_buffer_size system variable
#Sort_rows 			unit: rows 			Des:The number of sorted rows
#Sort_scan 			unit: sorts 		Des:The number of sorts that were done by scanning the table
#Sort_range			unit: sorts 		Des:The number of sorts that were done using ranges



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Mysql_Sort"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	sort per second"

	echo "merge.type	DERIVE"
	echo "merge.min	0"
	echo "merge.draw	LINE2"
	echo "merge.label	merge passes"

	echo "range.type	DERIVE"
	echo "range.min	0"
	echo "range.draw	LINE2"
	echo "range.label	range"

	echo "rows.type	DERIVE"
	echo "rows.min	0"
	echo "rows.draw	LINE2"
	echo "rows.label	rows"

	echo "scan.type	DERIVE"
	echo "scan.min	0"
	echo "scan.draw	LINE2"
	echo "scan.label	scan"

	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	Merge=`$MYSQLADMIN | grep "Sort_merge_passes " | awk '{print $4}'`
	Range=`$MYSQLADMIN | grep "Sort_range " | awk '{print $4}'`
	Rows=`$MYSQLADMIN | grep "Sort_rows " | awk '{print $4}'`
	Scan=`$MYSQLADMIN | grep "Sort_scan " | awk '{print $4}'`

	echo "merge.value	${Merge}"
	echo "range.value	${Range}"
	echo "rows.value	${Rows}"
	echo "scan.value	${Scan}"
fi