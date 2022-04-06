#!/bin/bash
oc adm

#creation of scc exam sample
oc new-project test-scc
oc new-app --name gitlab --docker-image quay.io/redhattraining/gitlab-ce:8.4.3-ce.0

