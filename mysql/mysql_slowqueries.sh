#!/bin/sh
# -*- sh -*-

: << =cut

=head1 NAME

mysql_slowqueries - Plugin to monitor the number of slow queries on a
mysql-server

=head1 CONFIGURATION

The following environment variables are used by this plugin:

 mysqlopts - Options to pass to mysql

=head1 AUTHOR

Unknown author

=head1 LICENSE

Unknown license

=head1 MAGIC MARKERS

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
	echo 'graph_title MySQL slow queries'
	echo 'graph_args --base 1000 -l 0'
	echo 'graph_vlabel slow queries / ${graph_period}'
	echo 'graph_category mysql'
	echo 'graph_info Note that this is a old plugin which is no longer installed by default.  It is retained for compatability with old installations.'

	echo 'queries.label slow queries'
	echo 'queries.type DERIVE'
	echo 'queries.min 0'
	echo 'queries.max 500000'
	exit 0
fi

/usr/bin/printf "queries.value "
($MYSQLADMIN $MYSQLOPTS status 2>/dev/null || echo a a a a a a a a U) | awk '{print $9}'