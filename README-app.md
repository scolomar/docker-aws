This project will allow you to deploy a containerized application in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will deploy your application in a previously created cluster. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
apps=" aws2cloud.yaml aws2prem.yaml app3.yml "                          \
branch_app=master                                                       \
debug=false                                                             \
debug=true                                                              \
deploy=latest                                                           \
deploy=release                                                          \
branch_docker_aws=master                                                \
repository_docker_aws=docker-aws                                        \
username_docker_aws=secobau                                             \
domain=raw.githubusercontent.com                                        \
mode=kubernetes                                                         \
mode=swarm                                                              \
repository_app=proxy2aws                                                    \
stack=proxy2aws                                                         \
username_app=secobau                                                        \
                                                                        ;
#########################################################################
export apps                                                             \
&&                                                                      \
export AWS=$username_docker_aws/$repository_docker_aws/$branch_docker_aws \
&&                                                                      \
export branch_app                                                       \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export deploy                                                           \
&&                                                                      \
export domain                                                           \
&&                                                                      \
export mode                                                             \
&&                                                                      \
export repository_app                                                       \
&&                                                                      \
export stack                                                            \
&&                                                                      \
export username_app                                                         \
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

The following command will swap back the load balancer so as to point again to the GREEN deployment:
```BASH


#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-target-green.sh                                                \
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


