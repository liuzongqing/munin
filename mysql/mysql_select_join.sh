#!/bin/bash

#create by zongqing
#Select_full_join		unit: table scans 	Des:The number of joins that perform table scans because they do not use indexes. If this value is not 0, you should carefully check the indexes of your tables
#Select_full_range_join	unit: searches 		Des:The number of joins that used a range search on a reference table
#Select_range 			unit: ranges 		Des:The number of joins that used ranges on the first table. This is normally not a critical issue even if the value is quite large
#Select_range_check		unit: no keys 		Des:The number of joins without keys that check for key usage after each row. If this is not 0, you should carefully check the indexes of your tables
#Select_scan			unit: scan 			Des:The number of joins that did a full scan of the first table



if [[ $1 == "autoconf" ]]; then
	echo yes
	exit 0
elif [[ $1 == "config" ]]; then
	echo "graph_title	Mysql_Select_Join"
	echo "graph_category	mysql"
	echo "graph_args --base 1000"
	echo "graph_vlabel	average numbers per second"

	echo "full_join.type	DERIVE"
	echo "full_join.min	0"
	echo "full_join.draw	LINE2"
	echo "full_join.label	full_join"
	echo "full_join.warning 0"

	echo "full_range_join.type	DERIVE"
	echo "full_range_join.min	0"
	echo "full_range_join.draw	LINE2"
	echo "full_range_join.label	full_range_join"

	echo "range_check.type	DERIVE"
	echo "range_check.min	0"
	echo "range_check.draw	LINE2"
	echo "range_check.label	range_check"
	echo "range_check.warning 0"

	echo "scan.type	DERIVE"
	echo "scan.min	0"
	echo "scan.draw	LINE2"
	echo "scan.label	scan"

	exit 0
else
	MYSQLADMIN="/usr/bin/mysqladmin extended-status"
	FullJoin=`$MYSQLADMIN | grep "Select_full_join " | awk '{print $4}'`
	FullRangeJoin=`$MYSQLADMIN | grep "Select_full_range_join " | awk '{print $4}'`
	RangeCheck=`$MYSQLADMIN | grep "Select_range_check " | awk '{print $4}'`
	Scan=`$MYSQLADMIN | grep "Select_scan " | awk '{print $4}'`

	echo "full_join.value	${FullJoin}"
	echo "full_range_join.value	${FullRangeJoin}"
	echo "range_check.value	${RangeCheck}"
	echo "scan.value	${Scan}"
fi