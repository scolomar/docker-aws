This project will allow you to deploy a containerized application in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.


The following script will first create the infrastructure and then deploy your application. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:


```BASH



#########################################################################
branch_docker_aws=master                                                \
debug=false                                                             \
debug=true                                                              \
docker_repository=docker-aws                                            \
docker_username=secobau                                                 \
domain=raw.githubusercontent.com                                        \
                                                                        ;
#########################################################################
export AWS=$docker_username/$docker_repository/$branch_docker_aws       \
&&                                                                      \
export branch_docker_aws                                                \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export domain                                                           \
                                                                        ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=init.sh                                                            \
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


You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:


```BASH



#########################################################################
## TO REMOVE THE CLOUDFORMATION STACK                                   #
aws cloudformation delete-stack --stack-name $stack                     ;
#########################################################################



```



