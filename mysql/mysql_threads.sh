#!/bin/sh
# -*- sh -*-

: << =cut

=head1 NAME

mysql_threads - Plugin to monitor the number of threads on a mysql-server.

=head1 CONFIGURATION

Configuration parameters for /etc/munin/mysql_threads, if you
need to override the defaults below:

 [mysql_threads]
  env.mysqlopts    - Options to pass to mysql

=head2 DEFAULT CONFIGURATION

 [mysql_threads]
  env.mysqlopts

=head1 AUTHOR

Unknown author

=head1 LICENSE

Unknown license

=head1 MAGIC MARKERS

=begin comment

These magic markers are used by munin-node-configure when installing
munin-node.

=end comment

 #%# family=manual
 #%# capabilities=autoconf

=cut

MYSQLOPTS="$mysqlopts"
MYSQLADMIN=${mysqladmin:-mysqladmin}

if [ "$1" = "autoconf" ]; then
        $MYSQLADMIN --version 2>/dev/null >/dev/null
        if [ $? -eq 0 ]
        then
                $MYSQLADMIN $MYSQLOPTS status 2>/dev/null >/dev/null
                if [ $? -eq 0 ]
                then
                        echo yes
                        exit 0
                else
                        echo "no (could not connect to mysql)"
                fi
        else
                echo "no (mysqladmin not found)"
        fi
        exit 0
fi

if [ "$1" = "config" ]; then
	echo 'graph_title MySQL threads'
	echo 'graph_vlabel threads'
	echo 'graph_category mysql'
	echo 'graph_info Note that this is a old plugin which is no longer installed by default.  It is retained for compatability with old installations.'
	
	echo 'threads.label mysql threads'
	echo 'graph_args --base 1000'
	exit 0
fi

/usr/bin/printf "threads.value "
($MYSQLADMIN $MYSQLOPTS status 2>/dev/null || echo 'a a a U') | awk '{print $4}'