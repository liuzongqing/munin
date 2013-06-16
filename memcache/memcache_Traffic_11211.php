#!/usr/bin/php
<?php
	error_reporting(0);
	$ScriptName = split("_|\.php", $argv[0]);
	if(count($ScriptName) < 3){
		echo "The script file name has a bad format,please keep file name format: category_title_port";
		exit(1);
	}

	$Category = "memcache";
	$Name = $ScriptName[1];
	$port = $ScriptName[2];
	$host = "127.0.0.1";
	$timeout = 5;

	// Connect memcache
	$obj = memcache_connect($host,$port,$timeout);
	// Get the current status
	$Stats = memcache_get_stats($obj);

	$uptime = $Stats['uptime'];
	
	$curr_connections = $Stats['curr_connections'];
	$total_connections = $Stats['total_connections'];
	
	$total_items = $Stats['total_items'];
	$curr_items = $Stats['curr_items'];

	$bytes_written = $Stats['bytes_written'];
	$bytes_read = $Stats['bytes_read'];

	$evictions = $Stats['evictions'];

	$cmd_get = $Stats['cmd_get'];
	$cmd_set = $Stats['cmd_set'];

	$get_hits = $Stats['get_hits'];
	$get_misses = $Stats['get_misses'];

	$totalmemsize = $Stats['limit_maxbytes'];
	$writememsize = $Stats['bytes'];


	// put data into rrd
	if ($argv[1] == "autoconf") {
		echo "yes";
		exit(0);
	} elseif ($argv[1] == "config") {
		echo "graph_order read write\n";
		echo "graph_title $Name\n";
		echo "graph_args --base 1000 -l 0\n";
		echo "graph_vlabel bits read(-) / write(+) per second\n";
		echo "graph_category $Category\n";
		echo "read.label $Name\n";
		echo "read.draw LINE2\n";
		echo "read.type DERIVE\n";	//GAUGE,DERIVE,COUNTER,ABSOLUTE
		echo "read.graph no\n";
		echo "read.min 0\n";
		echo "write.label $Name\n";
		echo "write.draw LINE2\n";
		echo "write.min 0\n";
		echo "write.type DERIVE\n";
		echo "write.negative read\n";
		exit(0);
	} else {
		echo "read.value $bytes_read\n";
		echo "write.value $bytes_written\n";
		exit(0);
	}

?>