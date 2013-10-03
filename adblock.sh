#!/bin/sh

# Down the DNSmasq formatted ad block list
curl "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=dnsmasq&showintro=0&mimetype=plaintext" | sed "s/127\.0\.0\.1/127\.0\.0\.1#8888/">/jffs/dnsmasq.adblock.conf


# Download another list, manipulate and echo to host file instead, easier
wget -O - http://www.mvps.org/winhelp2002/hosts.txt |
        grep 127.0.0.1 |
        sed '2,$s/127.0.0.1/0.0.0.0/g; s/[[:space:]]*#.*$//g;' |
        grep -v localhost |
        tr ' ' '\t' |
        tr -s '\t' |
        tr -d '\015' |
        sort -u >/tmp/hosts0

echo "addn-hosts=/tmp/hosts0" >> /jffs/dnsmasq.adblock.conf


# Reboot dnsmasq, important, lose internet if this fails
killall dnsmasq
dnsmasq -c 1500 --log-async -n


