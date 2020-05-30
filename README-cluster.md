This project will deploy a Docker cluster in AWS in a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The infrastructure should have been previously created with the corresponding template that will create 6 EC2 machines spread on 3 different Availability Zones with Docker-CE installed, 3 Private and Public Subnets, 3 NAT Gateways, 3 Security Groups, 3 Application Load Balancers and the necessary Routes, Roles and attachments to ensure the isolation of the EC2 machines and the security and resilience of the whole infrastructure.

The reason to have 3 Application Load Balancers is to make it available to 3 different internet service applications. The access from internet to the applications will be through the ALB standard ports (HTTP/HTTPS).

The EC2 machines do not have any open port accessible from outside.

We will use AWS Systems Manager to connect and maintain the EC2 machines without the need of any bastion or breaking the isolation.

With the predefined configuration in the CloudFormation file you can install up to 3 different external services that will be listening on standard port HTTPS of the 3 external Application Load Balancers:
* https://service-1.sebastian-colomar.com
* https://service-2.sebastian-colomar.com
* https://service-3.sebastian-colomar.com

There is also added support for QA and Blue/Green deployments so that you can connect to port 8443 to check the result of the Blue deployment:
* https://service-1.sebastian-colomar.com:8443
* https://service-2.sebastian-colomar.com:8443
* https://service-3.sebastian-colomar.com:8443

You can modify the weight of the load balancer so as to point to the Green or to the Blue deployment as necessary.

You might need the following documentation if you want to connect to the machines via SSH (but it is not necessary in principle):
* https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html
* https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-linux

The following script will create the cluster in AWS. You can choose between Kubernetes and Swarm as the orchestrator of your cluster.

You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
branch_docker_aws=master                                                \
debug=false                                                             \
debug=true                                                              \
domain=raw.githubusercontent.com                                        \
HostedZoneName=sebastian-colomar.com                                    \
mode=kubernetes                                                         \
mode=swarm                                                              \
stack=proxy2aws                                                         \
                                                                        ;
#########################################################################
export AWS=$username_docker_aws/$repository_docker_aws/$branch_docker_aws \
&&                                                                      \
export branch_docker_aws                                                \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export domain                                                           \
&&                                                                      \
export HostedZoneName                                                   \
&&                                                                      \
export mode                                                             \
&&                                                                      \
export stack                                                            \
&&                                                                      \
                                                                        ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=cluster-init.sh                                                    \
path=$AWS/bin                                                           \
                                                                        ;
#########################################################################
mkdir $date                                                             \
&&                                                                      \
cd $date                                                                \
&&                                                                      \
curl --remote-name https://$domain/$path/$file                          \
&&                                                                      \
chmod +x ./$file                                                        \
&&                                                                      \
nohup ./$file                                                           &
#########################################################################



```


You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:


```BASH


#########################################################################
## TO REMOVE THE CLOUDFORMATION STACK                                   #
aws cloudformation delete-stack --stack-name $stack                     ;
#########################################################################


```



