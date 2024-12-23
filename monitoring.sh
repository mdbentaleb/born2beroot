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
