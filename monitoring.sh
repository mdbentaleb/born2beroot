#!/bin/bash

archit=$(uname -a | sed "s/ PREEMPT_DYNAMIC//")
pcpu=$(lscpu | grep "^Socket(s):" | awk '{print $2}')
vcpu=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
arm=$(free -m | awk '$1 == "Mem:" {print $2}')
urm=$(free -m | awk '$1 == "Mem:" {print $3}')
prm=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
adm=$(df -BG | grep '^/dev/' | grep -v '/boot$' | awk '{am += $2} END {print am}')
udm=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{um += $3} END {print um}')
pdm=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{um += $3} {am += $2} END {printf("%d"), um/am*100}')
cpul=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_op=$(expr 100 - $cpul)
cpu_fin=$(printf "%.1f%%" $cpu_op)

wall " #Architecture: $archit
	#CPU physical  $pcpu
	#vCPU : $vcpu
	#Memory Usage: $urm/${arm}MB ($prm%)
	#Disk Usage: $udm/${adm}Gb ($pdm%)
	#CPU load: $cpu_fin"




-------------------------------


#!/bin/bash

# ARCH
arch=$(uname -a)

# CPU PHYSICAL
cpuf=$(grep "physical id" /proc/cpuinfo | wc -l)

# CPU VIRTUAL
cpuv=$(grep "processor" /proc/cpuinfo | wc -l)

# RAM
ram_total=$(free --mega | awk '$1 == "Mem:" {print $2}')
ram_use=$(free --mega | awk '$1 == "Mem:" {print $3}')
ram_percent=$(free --mega | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

# DISK
disk_total=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_t += $2} END {printf ("%.1fGb\n"), disk_t/1024}')
disk_use=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u}')
disk_percent=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} {disk_t+= $2} END {printf("%d"), disk_u/disk_t*100}')

# CPU LOAD
cpul=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_op=$(expr 100 - $cpul)
cpu_fin=$(printf "%.1f" $cpu_op)

# LAST BOOT
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')

# LVM USE
lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

# TCP CONNEXIONS
tcpc=$(ss -ta | grep ESTAB | wc -l)

# USER LOG
ulog=$(users | wc -w)

# NETWORK
ip=$(hostname -I)
mac=$(ip link | grep "link/ether" | awk '{print $2}')

# SUDO
cmnd=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "	Architecture: $arch
	CPU physical: $cpuf
	vCPU: $cpuv
	Memory Usage: $ram_use/${ram_total}MB ($ram_percent%)
	Disk Usage: $disk_use/${disk_total} ($disk_percent%)
	CPU load: $cpu_fin%
	Last boot: $lb
	LVM use: $lvmu
	Connections TCP: $tcpc ESTABLISHED
	User log: $ulog
	Network: IP $ip ($mac)
	Sudo: $cmnd cmd"
