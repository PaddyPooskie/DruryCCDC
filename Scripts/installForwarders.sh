#!/bin/sh

# This EXAMPLE script shows how to deploy the Splunk universal forwarder
# to many remote hosts via ssh and common Unix commands.
# For "real" use, this script needs ERROR DETECTION AND LOGGING!!

# --Variables that you must set -----

# Populate this file with a list of hosts that this script should install to,
# with one host per line. This must be specified in the form that should
# be used for the ssh login, ie. username@host
#
# Example file contents:
# splunkuser@10.20.13.4
# splunkker@10.20.13.5
HOSTS_FILE="$HOME/whereToInstallUF"

# This should be a WGET command that was *carefully* copied from splunk.com!!
# Sign into splunk.com and go to the download page, then look for the wget
# link near the top of the page (once you have selected your platform)
# copy and paste your wget command between the ""
WGET_CMD="wget -O splunkforwarder..."

# Set the install file name to the name of the file that wget downloads
# (the second argument to wget)
INSTALL_FILE="splunkforwarder..."

# After installation, the forwarder will become a deployment client of this
# host.  Specify the host and management (not web) port of the deployment server
# that will be managing these forwarder instances.
DEPLOY_SERVER="xxx.xxx.xxx.xxx:8089"

# Set the new Splunk admin password
PASSWORD="newpassword"

# ----------- End of user settings -----------

# create script to run remotely. Watch out for line wraps, esp. in the "set deploy-poll" line below.  
# the remote script assumes that 'splunkuser' (the login account) has permissions to write to the
# /opt directory (this is not generally the default in Linux)
REMOTE_SCRIPT="
cd /opt
$WGET_CMD
tar -xzf $INSTALL_FILE
# /opt/splunkforwarder/bin/splunk enable boot-start -user splunkusername
/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --auto-ports --no-prompt
/opt/splunkforwarder/bin/splunk set deploy-poll \"$DEPLOY_SERVER\" --accept-license --answer-yes --auto-ports --no-prompt  -auth admin:changeme
/opt/splunkforwarder/bin/splunk edit user admin -password $PASSWORD -auth admin:changeme
/opt/splunkforwarder/bin/splunk restart
"    
echo "In 5 seconds, will run the following script on each remote host:"
echo
echo "===================="
echo "$REMOTE_SCRIPT"
echo "===================="
echo
sleep 5
echo "Reading host logins from $HOSTS_FILE"
echo
echo "Starting."

for DST in `cat "$HOSTS_FILE"`; do
  if [ -z "$DST" ]; then
    continue;
  fi
  echo "---------------------------"
  echo "Installing to $DST"

  # run script on remote host - you will be prompted for the password
  ssh "$DST" "$REMOTE_SCRIPT"

done  
echo "---------------------------"
echo "Done"
