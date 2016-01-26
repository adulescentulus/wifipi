
#!/bin/sh
sed -i '/####wifipi_setup####/,$ d' /etc/network/interfaces
cat ./src/interfaces >> /etc/network/interfaces
sed -i 's/[#]*DAEMON_CONF=.*/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd
cp ./src/hostapd.conf /etc/hostapd/
cp ./src/dnsmasq.conf /etc/dnsmasq.d/wifipi
cp ./src/wpa_supplicant.conf /etc/wpa_supplicant/
sed -i 's/^[#]*net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p
iptables -F --table nat
iptables -F
iptables --table nat --append POSTROUTING --out-interface wlan1 -j MASQUERADE
iptables --append FORWARD --in-interface wlan0 -j ACCEPT

