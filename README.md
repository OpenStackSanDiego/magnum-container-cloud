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

While it is deploying, click the cluster name and the stack id to see the template engine (HEAT) deploying the various components. You'll see the networks, virtual machine instances, and security groups being deployed.

Click "Compute->Instances" to see the virtual machines instances that are deployed as part of the K8s deployment. You'll see both master and slave instances.

Click "Network->Security Groups" to see the security groups that were created for the master and slave instances. 

Click "Network->Network Topology->Graph" to see the segmented virtual networks that were created.

Log into the Kubernetes master node via SSH and verify that Kubernetes is ready. Use the Magnum key created above.

````
sudo su -
kubectl cluster-info
````

## Second Kubernetes Deployment

We'll create a second Kubernetes deployment using the same template.

* Cluster Templates->Kubernetes-Atomic->Create Cluster
 
  __Info__
  * Cluster Name: ````Kubernetes-Atomic-Prod````
  
  __Size__
  * Master Count: 1
  * Node Count: 2
  
* Click Submit

Notice how the new cluster has it's own segmented network, virtual machines, and security groups from the other cluster.

## Scale Up

We'll scale up the cluster to increate the computing power available to the cluster. We'll increase the cluster node count from 2 to 3.

* Cluster->Kubernetes-Atomic-Prod->Update Cluster

  __Size__
  * Master Count: 1
  * Node Count: 2 -> 3
  
Submit

Notice how the cluster has grown to include a new virtual machine as part of the cluster. Click through to the "Compute Instances" and the "Network Topology" to see the change.

## Cluster Shutdown

Go ahead and shutdown one of the clusters (Kubernetes-Atomic-Prod). Notice how the network, virtual machines, and security groups are deallocated.

## Startup a Docker Swarm Cluster

Repeat the steps above with a new template and cluster. Replace the COE with "Docker Swarm"

Click through to the see the templated deployment, compute instances, network security groups, and networks created.

Log into the Docker master node via SSH. Use the Magnum key created above.

Startup the basic Docker container to verify functionality (this required root access).

* sudo su -
* docker run helloworld


## Shutting it all down

From the Packet Application website, select the bare metal server and mark it for deletion.

You are welcome to keep the server running but remember that you will keep being charged until you delete it via the Packet web app.
