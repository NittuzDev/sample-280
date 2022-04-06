#!/bin/bash

#lab install-troubleshoot start

source /usr/local/etc/ocp4.config
echo ${RHT_OCP4_KUBEADM_PASSWD} >> /home/student/Documents/master_pass.txt
oc login -u kubeadmin -p ${RHT_OCP4_KUBEADM_PASSWD} ${RHT_OCP4_MASTER_API}

# taint nodes
oc adm taint nodes master01 deploy=here:NoSchedule
oc label node master01 deploy=here
oc adm taint nodes master02 dev=restricted:NoSchedule
oc adm taint nodes master03 dev=restricted:NoSchedule

# nodeselector
oc new-project nginx-app
oc apply -f nginx-app/deployment.yaml
oc apply -f nginx-app/service.yaml
oc expose svc/nginx

# creation of scc exam sample
oc new-project test-scc
oc new-app --name gitlab --docker-image quay.io/redhattraining/gitlab-ce:8.4.3-ce.0

oc project default