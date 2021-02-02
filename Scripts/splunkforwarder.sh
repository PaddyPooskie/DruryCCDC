# Install and configure the Splunk universal forwarder

## Install and start the Splunk universal forwarder

echo Installing and starting the Splunk universal forwarder

sudo wget -O splunkforwarder-6.0-182037-Linux-x86_64.tgz 'http://download.splunk.com/releases/6.0/universalforwarder/linux/splunkforwarder-6.0-182037-Linux-x86_64.tgz' &&

sudo tar xvzf splunkforwarder-6.0-182037-Linux-x86_64.tgz -C /opt &&

sudo /opt/splunkforwarder/bin/splunk start --accept-license &&

## Configure the Splunk universal forwarder

echo Configuring the Splunk universal forwarder

sudo /opt/splunkforwarder/bin/splunk enable boot-start &&

sudo /opt/splunkforwarder/bin/splunk edit user admin -password cisq35201! -role admin -auth admin:changeme

sudo /opt/splunkforwarder/bin/splunk add forward-server 172.20.241.20:9997 -auth admin:cisq35201! &&

sudo /opt/splunkforwarder/bin/splunk add monitor /var/log &&

sudo /opt/splunkforwarder/bin/splunk restart &&

wait 45

sudo cat /opt/splunkforwarder/etc/system/local/outputs.conf
