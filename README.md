adblock
=======

A handy script to place on most any router with terminal access.  

This will DNS redirect all known ad sites to localhost.


TODO
=====
- instructions for use
- make redirection configurable
- instructions for setting up a 1x1 pixel webpage host

Setup On Router
=====

Requires a router that you can SSH to and install applications on (DD-WRT, Tomato, AsusMerlin for example).

Start by creating a fake ip address in iptables.  This is where we will redirect all ad traffic too but it does not have to be a real computer.  The issue is that dnsmasq will not let us change the port in use.  Often routers are already using their port 80/443 for a control panel.  You can ignore this step if you want to change the port in which your routers control panel software runs on.  If not the following line will take traffic directed to 192.168.0.222:80 and send it to 192.168.1.106:88.
```
iptables -t nat -A prerouting_lan -d 192.168.0.222 -p tcp --dport 80 -j DNAT --to 127.0.0.1:88
```
