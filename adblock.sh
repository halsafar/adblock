#!/bin/sh

#
# Simple AdBlock Script
#

ADBLOCK_HOSTS="/tmp/hosts.clean"
DNS_CONF_FILE="/jffs/dnsmasq.adblock.conf"
DNS_CONF_LINE="addn-hosts=$ADBLOCK_HOSTS";
ROUTER_IP="192.168.1.106"

# Down the DNSmasq formatted ad block list
echo "Downloading AdBlock files... Parsing for dnsmasq..."
wget -qO- "http://winhelp2002.mvps.org/hosts.txt" "http://someonewhocares.org/hosts/zero/hosts" "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&startdate[day]=&startdate[month]=&startdate[year]=&mimetype=plaintext&useip=0.0.0$
     grep -w ^0.0.0.0 |
     sed $'s/\r$//;s/0.0.0.0/192.168.1.106/' |
     sed $'s:#.*$::g' |
     sort -u > $ADBLOCK_HOSTS

# remove entries from list - hacked in whitelist for now
echo "Whitelisting entries..."
sed -i '/.*admob.*/d' $ADBLOCK_HOSTS

# add line to dnsmasq config file
echo "addn-hosts=$ADBLOCK_HOSTS" > $DNS_CONF_FILE

# Reboot dnsmasq, important, cannot use dns locally if this fails
echo "Rebooting dnsmasq..."
killall dnsmasq
dnsmasq -c 1500 --log-async -n
