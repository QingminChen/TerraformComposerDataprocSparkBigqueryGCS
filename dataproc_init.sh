#!/bin/bash
sudo mkdir -p /testproject/security
sudo chmod o+w -R /testproject
sudo chmod o+r -R /testproject
sudo chmod o+x -R /testproject
sudo chmod o+w -R /testproject/security
sudo chmod o+r -R /testproject/security
sudo chmod o+x -R /testproject/security
cd /testproject/security/
gsutil cp gs://integrate-source-code/security/AllServicesKey.json .

