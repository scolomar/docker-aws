This project will allow you to deploy a containerized application in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will deploy your application in a previously created cluster. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
branch_docker_aws=master                                                \
debug=false                                                             \
debug=true                                                              \
domain=raw.githubusercontent.com                                        \
mode=kubernetes                                                         \
mode=swarm                                                              \
repository_docker_aws=docker-aws                                        \
stack=docker                                                            \
username_docker_aws=secobau                                             \
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
export mode                                                             \
&&                                                                      \
export stack                                                            \
                                                                        ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=app-init.sh                                                        \
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



If you are running a BLUE/GREEN deployment the following commands will be useful.

The following command will swap the load balancer so as to point to the BLUE deployment:
```BASH


#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-target-blue.sh                                                 \
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

The following command will swap back the load balancer so as to point again to the GREEN deployment:
```BASH


#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-target-green.sh                                                \
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


