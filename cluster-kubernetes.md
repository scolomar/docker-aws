Please follow these instructions in order to create a Kubernetes cluster:

1. Initialize the cluster in the leader master: 
   * [Leader initialization](bin/cluster-kubernetes-leader.sh)
1. Follow the installation in the rest of the masters using the tokens provided in the previous step: 
   * [Master initialization](bin/cluster-kubernetes-master.sh)
1. Follow the installation in the rest of the workers using the tokens provided in the previous step: 
   * [Worker initialization](bin/cluster-kubernetes-worker.sh)
