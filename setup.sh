#!/bin/bash

lab install-troubleshoot start

# taint nodes
oc adm taint nodes master01 deploy:here:NoSchedule
oc label node master01 deploy=here
oc adm taint nodes master02 dev:restricted:NoSchedule
oc adm taint nodes master03 dev:restricted:NoSchedule

# nodeselector 
oc new-project nginx-app

# creation of scc exam sample
oc new-project test-scc
oc new-app --name gitlab --docker-image quay.io/redhattraining/gitlab-ce:8.4.3-ce.0

