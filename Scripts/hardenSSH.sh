#!/bin/bash
sudo sed -i '/^Protocol/s/1/2/' /etc/ssh/sshd_config
#Insert AllowUsers
#Insert DenyUser
sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^HostbasedAuthentication/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^AllowTcpForwarding/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^X11Forwarding/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^LogLevel/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^PermitEmptyPasswords/s/yes/no/' /etc/ssh/sshd_config
sudo service ssh restart
