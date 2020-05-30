This project will allow you to deploy a containerized application in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will first create the infrastructure and then deploy your application. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
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
HostedZoneName=sebastian-colomar.com                                    \
Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                         \
KeyName=proxy2aws                                                       \
mode=kubernetes                                                         \
mode=swarm                                                              \
RecordSetName1=dockercoins                                              \
RecordSetName2=petclinic                                                \
RecordSetName3=php                                                      \
repository_app=proxy2aws                                                    \
s3name=docker-aws                                                       \
s3region=ap-south-1                                                     \
stack=docker                                                            \
template=https.yaml                                                     \
TypeManager=t3a.nano                                                    \
TypeWorker=t3a.micro                                                    \
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
export branch_docker_aws                                                \
&&                                                                      \
export repository_docker_aws                                            \
&&                                                                      \
export domain                                                           \
&&                                                                      \
export HostedZoneName                                                   \
&&                                                                      \
export Identifier                                                       \
&&                                                                      \
export KeyName                                                          \
&&                                                                      \
export mode                                                             \
&&                                                                      \
export RecordSetName1                                                   \
&&                                                                      \
export RecordSetName2                                                   \
&&                                                                      \
export RecordSetName3                                                   \
&&                                                                      \
export repository_app                                                       \
&&                                                                      \
export s3name                                                           \
&&                                                                      \
export s3region                                                         \
&&                                                                      \
export stack                                                            \
&&                                                                      \
export template                                                         \
&&                                                                      \
export TypeManager                                                      \
&&                                                                      \
export TypeWorker                                                       \
&&                                                                      \
export username_app                                                         \
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


