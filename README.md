# Building a Cloud to run Containers


## Overview


| |
|----------|
| Container | Container | Container | ... |
| COE-1 | COE-2 | ... |
|OpenStack VM-1, VM-2, VM-3... |
|OpenStack Controller |
|     Bare Metal Server 32GB, 120TB, 4 core Xeon (CentOS 7)          |



## Prerequisites

For this lab, you'll need a desktop/laptop (Windows, Mac, or Linux) with an SSH client and a web browser.

You can download PuTTY, an SSH client for Windows at:

https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html

Install the Windows package since you'll need one of the PuTTY utilities (putty and puttygen).

## Bare Metal Service Account

For this workshop, you'll be using physical servers provided by Packet. Specifically, you'll be using one of their 'Type 1' servers, a 32 GB, 120GB x 2 SSD (RAID-1), 4 core Xeon server. Packet provides their servers by the hour. With code SDOPENSTACK, you'll get $25 of free credit. The 'Type 1' is $0.40/hour so the $25 credit will get you 62 hours of CPU use. Be sure to shut down the server at the end of the workshop!

Sign up at www.packet.net and use code SDOPENSTACK. You'll need to provide a credit card or PayPal account to get the $25 in free credit.

## Startup a Bare Metal Server

Packet has instructions on how to startup your first server. 
You'll want to deploy a 'Type 1' server. Pick whichever region you'd like (New Jersey or California).

https://help.packet.net/quick-start/deploy-a-server

After creating a project make sure to use the following settings for deploying the server

Hostname: Magnum

Project:  Your Project Name

Config:  Type I

OS:  CentOS 7

Location: Parsippany, NJ 

If you are connecting from a Windows machine, you can use these instructions on how to generate SSH keys.

https://help.packet.net/quick-start/generate-ssh-keys

Make sure you upload your new key into Packet before you start the server!

It'll take about 8 minutes for the new server to start up.

## Log into the Bare Metal Server

Using PuTTY (Windows) or ssh (Mac/Linux), connect to the new bare metal, physical server that was deployed. Refer to step #5 in the Packet guide above if you need help. You'll be logging as as 'root' with no password required (SSH keys used instead of the password).

When connecting using PuTTY on Windows, use the following instructions to login using the SSH key generated above.

* Click Connection > Data in the left-hand navigation pane and set the Auto-login username to root.

* Click Connection > SSH > Auth in the left-hand navigation pane and configure the private key to use by clicking Browse under Private key file for authentication.

* Navigate to the location where you saved your private key earlier, select the file, and click Open.* 

## Download and Run Install Scripts

Once the you're logged in as root execute the following commands. The git command downloads the scripts to setup VirtualBox and Fuel. The "setup-fuel.sh" installs VirtualBox and downloads the Fuel scripts.

* yum -y install git
* git clone https://github.com/OpenStackSanDiego/magnum-container-cloud
* cd magnum-container-cloud
* sh setup-magnum.sh

## Shutting it all down

From the Packet Application website, select the bare metal server and mark it for deletion.

You are welcome to keep the server running but remember that you will keep being charged until you delete it via the Packet web app.

