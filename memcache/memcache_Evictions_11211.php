#!/usr/local/php/bin/php
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


	// put data into rrd
	if ($argv[1] == "autoconf") {
		echo "yes";
		exit(0);
	} elseif ($argv[1] == "config") {
		echo "graph_order evictions\n";
		echo "graph_title $Name\n";
		echo "graph_args --base 1000 -l 0\n";
		echo "graph_vlabel evictions per second\n";
		echo "graph_category $Category\n";
		echo "evictions.label $Name\n";
		echo "evictions.draw LINE2\n";
		echo "evictions.type DERIVE\n";	//GAUGE,DERIVE,COUNTER,ABSOLUTE
		echo "evictions.min 0\n";
		exit(0);
	} else {
		echo "evictions.value $evictions\n";
		exit(0);
	}

?>