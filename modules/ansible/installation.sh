#!/bin/bash
#CONFIG_FILE is address of ansible inventory file
export CONFIG_FILE=inventory/mycluster/hosts.yaml
#USE_REAL_HOSTNAME is switch to detect real hostname by inventory.py
export USE_REAL_HOSTNAME=true
#KUBE_MASTERS is total count of masters in inventory file
#export KUBE_MASTERS=3
export User_Name=ubuntu
export INSTALL_LOG=/var/log/k8s_install.log

### add private ssh key ###
touch /home/$User_Name/.ssh/id_rsa
chmod 600 /home/$User_Name/.ssh/id_rsa
echo "${private_key}" > /home/$User_Name/.ssh/id_rsa
chown $User_Name /home/$User_Name/.ssh/id_rsa
### install Prerequisite ###
apt update &>> $INSTALL_LOG
apt install jq -y &>> $INSTALL_LOG
apt install python3-pip -y &>> $INSTALL_LOG
pip3 install yq &>> $INSTALL_LOG

### clone kubespray ###
echo start clone kubespray &>> $INSTALL_LOG
git clone https://github.com/kubernetes-sigs/kubespray.git &>> $INSTALL_LOG
echo kubespray cloend. &>> $INSTALL_LOG


### prepare kubespray ###
cd kubespray
pip3 install ruamel_yaml &>> $INSTALL_LOG
pip3 install -r requirements.txt &>> $INSTALL_LOG
cp -rfp inventory/sample inventory/mycluster
chown -R $User_Name:$User_Name ../kubespray

### fix kubespray master worker separation bug ###
sed -i '369s/SCALE_THRESHOLD/0/' contrib/inventory_builder/inventory.py

### create ansible inventroy ###
su -c "python3 contrib/inventory_builder/inventory.py ${masterips}" -m $User_Name
su -c "python3 contrib/inventory_builder/inventory.py add ${workerips}" -m $User_Name

### create install.sh script ###
echo "ansible_ssh_common_args=-o \
StrictHostKeyChecking=no \
ansible-playbook -i inventory/mycluster/hosts.yaml \
-e ansible_user=ubuntu \
-e https_proxy=${http_proxy} \
-e http_proxy=${http_proxy} \
-e metrics_server_enabled=true \
-e ingress_nginx_enabled=true \
-e auto_renew_certificates=true \
-b cluster.yml" > install.sh

chmod +x install.sh

### print Guidelines ###
echo to beginning of installation run: /kubespray/install.sh &>> $INSTALL_LOG
echo 'initialization finished' &>> $INSTALL_LOG
echo '#################' &>> $INSTALL_LOG
echo '/kubespray/install.sh started...' &>> $INSTALL_LOG
/kubespray/install.sh &>> $INSTALL_LOG


