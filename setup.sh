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

# nodeselector problem
oc new-project nginx-app
oc apply -f nginx-app/deployment.yaml
oc apply -f nginx-app/service.yaml
oc expose svc/nginx

# scc problem
oc new-project test-scc
oc new-app --name gitlab --docker-image quay.io/redhattraining/gitlab-ce:8.4.3-ce.0

#memory exceeded + secret
oc new-project php-app
oc new-app --name php https://github.com/nicola-bertoli/sample-280 --context-dir php-app
oc set resources deployment php --requests=memory=80Gi


oc project default