Please follow these instructions in order to create a Kubernetes cluster:

1. Initialize the cluster in the leader master: https://github.com/secobau/docker-aws/blob/manual/bin/cluster-kubernetes-leader.sh
1. Follow the installation in the rest of the masters using the tokens provided in the previous step: https://github.com/secobau/docker-aws/blob/manual/bin/cluster-kubernetes-master.sh
1. Follow the installation in the rest of the workers using the tokens provided in the previous step: https://github.com/secobau/docker-aws/blob/manual/bin/cluster-kubernetes-worker.sh
