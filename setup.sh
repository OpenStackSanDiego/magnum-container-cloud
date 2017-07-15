yum -y update
yum install -y https://www.rdoproject.org/repos/rdo-release.rpm
yum install -y openstack-packstack
yum -y update

time packstack --allinone \
	--os-cinder-install=n \
	--nagios-install=n 	\
	--os-ceilometer-install=n \
	--os-neutron-ml2-type-drivers=flat,vxlan \
	--os-heat-install=y \
  --os-magnum-install=y
  
yum install -y openstack-magnum-ui


. ~/keystonerc_admin

IMG_URL=https://download.fedoraproject.org/pub/alt/atomic/stable/Fedora-Atomic-25-20170626.0/CloudImages/x86_64/images/Fedora-Atomic-25-20170626.0.x86_64.qcow2
IMG_NAME=Fedora-Atomic-25
OS_DISTRO=fedora-atomic
wget -q -O - $IMG_URL | \
glance  --os-image-api-version 2 image-create --protected True --name $IMG_NAME \
        --visibility public --disk-format raw --container-format bare --property os_distro='$OS_DISTRO' --progress
        
IMG_URL=https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2
IMG_NAME=CentOS-7
OS_DISTRO=centos
wget -q -O - $IMG_URL | \
glance  --os-image-api-version 2 image-create --protected True --name $IMG_NAME \
        --visibility public --disk-format raw --container-format bare --property os_distro='$OS_DISTRO' --progress

wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_openstack_image.img.bz2
bunzip2 coreos_production_openstack_image.img.bz2
IMG_URL=coreos_production_openstack_image.img
IMG_NAME=Container-Linux
OS_DISTRO=coreos
wget -q -O - $IMG_URL | \
glance  --os-image-api-version 2 image-create --protected True --name $IMG_NAME \
        --visibility public --disk-format raw --container-format bare --property os_distro='$OS_DISTRO' --progress
        
IMG_URL=http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
IMG_NAME=CirrOS-0.3.5
OS_DISTRO=cirros
wget -q -O - $IMG_URL | \
glance  --os-image-api-version 2 image-create --protected True --name $IMG_NAME \
        --visibility public --disk-format raw --container-format bare --property os_distro='$OS_DISTRO' --progress        


  

