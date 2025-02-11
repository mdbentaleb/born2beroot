# 🚀 Born2beRoot

## 📌 Overview
Born2beRoot is a system administration project from the 42 curriculum. This project introduces virtualization and server setup using Debian or Rocky Linux while enforcing strict security and system configuration rules.

## ✨ Features
- 🖥️ Virtual machine setup using VirtualBox (or UTM on macOS M1+).
- ❌ Server installation without a graphical interface.
- 🔐 LVM partitioning with at least two encrypted partitions.
- 🔑 SSH service running on port 4242 with restricted root login.
- 🔥 Firewall configuration using UFW (or Firewalld for Rocky Linux).
- 🛡️ Strict password policy enforcement.
- 🛠️ Secure sudo configuration with logging and custom security rules.
- 📊 Automated monitoring script displaying system information every 10 minutes.

## ✅ Mandatory Requirements
### 🖥️ System Setup
- Install Debian (recommended) or Rocky Linux as the OS.
- Ensure SELinux (Rocky) or AppArmor (Debian) is active.
- Create a hostname using your 42 login followed by '42'.
- Configure at least two encrypted LVM partitions.
- Enable and configure the firewall (UFW/Firewalld) with only port 4242 open.
- Prevent root SSH login.

### 👤 User and Security Configuration
- Create a user with your 42 login.
- Add the user to `user42` and `sudo` groups.
- Enforce strong password policies:
  - 🔄 Expiry every 30 days
  - ⏳ Minimum age of 2 days before password change
  - ⚠️ 7-day expiration warning
  - 🔠 Minimum 10 characters, mix of uppercase, lowercase, and numbers
  - 🚫 No more than 3 consecutive identical characters
  - ❌ Cannot contain username
- Secure `sudo` usage:
  - 🚫 Limit authentication attempts to 3
  - ✉️ Custom error message for incorrect sudo password
  - 📜 Log sudo actions to `/var/log/sudo/`
  - 🔒 Enable TTY mode
  - 📌 Restrict sudo executable paths

### 📊 Monitoring Script
- A `monitoring.sh` script must run every 10 minutes and display:
  - 🏗️ System architecture and kernel version
  - 🖥️ Number of physical and virtual CPUs
  - 💾 RAM and disk usage
  - 🔄 CPU load
  - ⏰ Last reboot time
  - 🖥️ LVM usage
  - 🔌 Active connections and users
  - 🌐 IPv4 and MAC address
  - 🔢 Number of sudo commands executed

## 🌟 Bonus (Optional)
- 💽 Additional partitioning setup.
- 🌍 Deployment of a WordPress website with Lighttpd, MariaDB, and PHP.
- 🔧 Setup of a useful custom service (excluding Apache/Nginx).

## 📜 Submission Guidelines
- 📄 Submit a `signature.txt` file containing the SHA-1 signature of the virtual disk.
- ✅ Ensure the signature matches during the defense.
- 🚫 Do not include the virtual machine in the repository.
