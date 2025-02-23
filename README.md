# wp-ubuntu-server-setup
This powerful Bash script fully automates the installation and setup of WordPress on an Ubuntu server, saving you time and effort.

You should be ssh'ed into a Linux instance with inbound rules that allow for port 80 and 22. 

This was tested with an Ubuntu AMI.

This is what the script does:
1. Updates the system and installs dependencies
2. Configures MySQL DB
3. Downloads and sets up WordPress
4. Configures Apache
5. Configures firewall
6. Explains how to access the resulting deployment in your browser
