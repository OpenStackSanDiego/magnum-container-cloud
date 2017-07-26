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

You'll also need an OpenStack Cloud with Magnum installed. See the following project for details on how to build such a cloud.

https://github.com/OpenStackSanDiego/OpenStack-on-Packet-Host/

## Cloud Login

Once everything has rebooted. Connect to the GUI at: http://YOUR_SERVER_IP/. Use the login admin with the OS_PASSWORD from above.

## Startup a Kubernetes Cluster

Create a new keypair called Magnum

* Project->Computer->Key Pairs->Create Key Pair
* Keypair Name: Magnum
* A magnum.pem file will be downloaded to your computer

Create a Kubernetes Cluster Template:

* Project->Container Infra->Cluster Templates>+ Create Cluster Templates
  
   __Info__    
  * Cluster Template Name: ````Kubernetes-Atomic````
  * Container Orchestration Engine: Kubernetes
  * Public: Checked
  * Disabled TLS: Checked
  
  __Node Spec__
   * Image: Fedora-Atomic-25
   * Keypair: Magnum
   
  __Network__
   * External Network ID: ````public```` (needs to be all lower case)
   * DNS: ````8.8.8.8````
   * Floating IP: Checked
 
 * Click submit

Create a Kubernetes Cluster based upon the template.

* Cluster Templates->Kubernetes-Atomic->Create Cluster
 
  __Info__
  * Cluster Name: ````Kubernetes-Atomic-Dev````
  
  __Size__
  * Master Count: 1
  * Node Count: 2
  
* Click Submit

Click through to the see the list of compute instances, network security groups, and networks created.

Log into the Kubernetes master node via SSH. Use the Magnum key created above.

## Startup a Docker Swarm Cluster

Repeat the steps above with a new template and cluster. Replace the COE with "Docker Swarm"

Click through to the see the list of compute instances, network security groups, and networks created.

Log into the Docker master node via SSH. Use the Magnum key created above.

Startup the basic Docker container to verify functionality (this required root access).

* sudo su -
* docker run helloworld


## Shutting it all down

From the Packet Application website, select the bare metal server and mark it for deletion.

You are welcome to keep the server running but remember that you will keep being charged until you delete it via the Packet web app.
