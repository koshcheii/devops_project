# Настройка автозагрузки и запуск модуля ядра br_netfilter и overlay
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# Разрешение маршрутизации IP-трафика
echo 'net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1' > /etc/sysctl.d/10-k8s.conf
sysctl -f /etc/sysctl.d/10-k8s.conf
