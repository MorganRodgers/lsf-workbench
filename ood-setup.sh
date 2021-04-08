#!/bin/bash

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

# Add user to system and apache basic auth
groupadd ood
useradd --create-home --gid ood ood
echo -n "ood" | passwd --stdin ood
scl enable httpd24 -- htpasswd -b -c /opt/rh/httpd24/root/etc/httpd/.htpasswd ood ood

# Set basic auth for ood
cat >> /etc/ood/config/ood_portal.yml << EOODF
auth:
  - 'AuthType Basic'
  - 'AuthBasicProvider file'
  - 'AuthUserFile /opt/rh/httpd24/root/etc/httpd/.htpasswd'
  - 'AuthName "Welcome Message."'
  - 'Require valid-user'
EOODF

# Misc
mkdir -p /etc/ood/config/clusters.d
mkdir -p /etc/ood/config/apps/shell
