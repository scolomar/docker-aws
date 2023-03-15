This project will show you how to deploy a Docker cluster in AWS.

You will learn how to deploy two different orchestrators: Swarm and Kubernetes.

The cluster will be highly available (HA) with 3 masters and 3 workers evenly distributed in 3 different availability zones located in the same AWS region.

1. Create the infrastructure in AWS: https://github.com/secobau/docker-aws/blob/manual/infra.md
1. Install the docker engine in every node: https://github.com/secobau/docker-aws/blob/manual/bin/aws-node-ami.sh

Steps to install the Swarm cluster:
1. Create the Swarm cluster starting with the leader master and executing afterwards the corresponding token in the rest of the masters and workers: https://github.com/secobau/docker-aws/blob/manual/bin/cluster-swarm-init.sh
1. Deploy a sample application in Swarm: https://github.com/secobau/docker-aws/blob/manual/bin/app-deploy-swarm.sh

Steps to install the Kubernetes cluster:
1. Install Kubernetes in every node: https://github.com/secobau/docker-aws/blob/manual/bin/cluster-kubernetes-install.sh
1. Create the Kubernetes cluster: https://github.com/secobau/docker-aws/blob/manual/cluster-kubernetes.md
1. Deploy a sample application in Kubernetes: https://github.com/secobau/docker-aws/blob/manual/bin/app-deploy-kubernetes.sh
