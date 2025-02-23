# wp-ubuntu-server-setup  

This powerful Bash script fully automates the installation and setup of WordPress on an Ubuntu server, saving you time and effort.  

With just one command, you'll have a fully functional WordPress site up and running—complete with Apache, MySQL, PHP, and all necessary configurations.  

---

## Features  

- **One-command setup** – Deploy WordPress effortlessly  
- **Optimized for speed** – No manual steps required  
- **Includes Apache & MySQL setup** – Secure and production-ready  

---

## Prerequisites  

- You should be **SSH'ed into your instance** with inbound rules that allow for **port 80 (HTTP)** and **port 22 (SSH)**.  
- This script was tested on an **Ubuntu AMI**.

---

## Instructions
- Navigate to the home directory with 'cd ~' (optional but recommended for organisation)
- Install 'git' in you haven't already with 'sudo apt update && sudo apt install -y git'
- Clone this repo with 'git clone https://github.com/pushon10/wp-ubuntu-server-setup.git'
- Navigate to the directory for the repo with 'cd wp-ubuntu-server-setup'
- Make the script executable with 'chmod +x wordpress_deployment.sh'
- Run the script with 'sudo ./wordpress_deployment.sh'

---

## What This Script Does  

1. **Updates the system** and installs required dependencies  
2. **Configures MySQL** and sets up a database for WordPress  
3. **Downloads and sets up WordPress** in the correct directory  
4. **Configures Apache** to serve WordPress properly  
5. **Configures the firewall** to allow web traffic  
6. **Provides instructions** on how to access the WordPress installation in your browser  

---

This script is designed to save time while ensuring a secure and properly configured WordPress deployment on Ubuntu.

