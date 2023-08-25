#! /bin/sh

# Allow user squid to write to stdout (for acces log)
chmod 777 /dev/stdout

# Launch squid in foreground, with debug in stdout and without kids
/usr/sbin/squid -NCd1
