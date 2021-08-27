#! /bin/bash

ip link add veth0 type veth peer name veth1
ifconfig veth0 192.168.1.1 netmask 255.255.255.0 up
ifconfig veth1 up
ethtool --offload veth0 tx off
ethtool --offload veth1 tx off

touch /dhcpd.leases
/usr/sbin/dnsmasq
/usr/sbin/dhcpd -lf /dhcpd.leases

sysctl net.ipv4.ip_forward=1
iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -d 192.168.1.0/24 -o veth0 -j ACCEPT
iptables -A FORWARD -s 192.168.1.0/24 -j ACCEPT

#Debug
ip link
ip addr
iptables -t nat -L -n
