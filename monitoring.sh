#!/bin/bash

#------------Architecture-----------
archit=$(uname -a | sed "s/ PREEMPT_DYNAMIC//")

#------------CPU physical-----------
pcpu=$(lscpu | grep "^Socket(s):" | awk '{print $2}')

#----------------vCPU---------------
vcpu=$(lscpu | grep "^CPU(s):" | awk '{print $2}')

#------------Memory Usage-----------
arm=$(free -m | awk '$1 == "Mem:" {print $2}')
urm=$(free -m | awk '$1 == "Mem:" {print $3}')
prm=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

#-------------Disk Usage------------
adm=$(df -BG | grep '^/dev/' | grep -v '/boot$' | awk '{am += $2} END {print am}')
udm=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{um += $3} END {print um}')
pdm=$(df -BM | grep '^/dev/' | grep -v '/boot$' | awk '{um += $3} {am += $2} END {printf("%d"), um/am*100}')

#--------------CPU load-------------
ucpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' | awk '{printf "%.1f", $1}')

#--------------Last boot------------
lb=$(uptime -s | cut -d: -f1,2)

#-----------------LVM---------------
lvm=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo -n "yes"; else echo -n "no"; fi)

#--------------tcp connex-----------
tcpc=$(ss -ta | grep -c 'ESTAB')

#---------------User log------------
ul=$(who | awk '{print $1}'| sort -u | wc -l)

#----------------Network------------
ip4=$(hostname -I)
maca=$(ip link | awk '$1 == "link/ether" {print $2}')

#-------------Sudo commands---------
scmd=$(journalctl _COMM=sudo -q | grep 'COMMAND' | wc -l)


wall " #Architecture: $archit
	#CPU physical  $pcpu
	#vCPU : $vcpu
	#Memory Usage: $urm/${arm}MB ($prm%)
	#Disk Usage: $udm/${adm}Gb ($pdm%)
	#CPU load: $ucpu%
	#Last boot: $lb
	#LVM use: $lvm
	#Connections TCP : $tcpc ESTABLISHED
	#User log: $ul
	#Network: IP $ip4 ($maca)
	#Sudo : $scmd cmd"
