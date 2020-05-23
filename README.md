This project will allow you to deploy a containerized application in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will first create the infrastructure and then deploy your application. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
# Identifier is the ID of the certificate in case you are using HTTPS   #
#########################################################################
apps=" app1.yml app2.yml app3.yml "                                     \
apps=" aws2cloud.yaml aws2prem.yaml "                                   \
branch=master                                                           \
debug=false                                                             \
debug=true                                                              \
deploy=latest                                                           \
deploy=release                                                          \
docker_branch=use-forks                                                      \
docker_repository=docker-aws                                            \
docker_username=secobau                                                 \
HostedZoneName=example.com                                              \
HostedZoneName=sebastian-colomar.com                                    \
Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                         \
KeyName=mySSHpublicKey                                                  \
KeyName=proxy2aws                                                       \
mode=kubernetes                                                         \
mode=swarm                                                              \
RecordSetName1=service-1                                                \
RecordSetName1=aws2cloud                                                \
RecordSetName2=service-2                                                \
RecordSetName2=aws2prem                                                 \
RecordSetName3=service-3                                                \
repository=myproject                                                    \
repository=proxy2aws                                                    \
stack=mystack                                                           \
stack=proxy2aws                                                         \
TypeManager=t3a.nano                                                    \
TypeWorker=t3a.nano                                                     \
username=johndoe                                                        \
username=secobau                                                        \
                                                                        ;
#########################################################################
export apps                                                             \
&&                                                                      \
export AWS=$docker_username/$docker_repository/$docker_branch           \
&&                                                                      \
export branch                                                           \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export deploy                                                           \
&&                                                                      \
export docker_branch                                                    \
&&                                                                      \
export docker_repository                                                \
&&                                                                      \
export docker_username                                                  \
&&                                                                      \
export domain=raw.githubusercontent.com                                 \
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
export repository                                                       \
&&                                                                      \
export s3name=$docker_repository                                        \
&&                                                                      \
export s3region=ap-south-1                                              \
&&                                                                      \
export stack                                                            \
&&                                                                      \
export template=cloudformation-https.yaml                               \
&&                                                                      \
export TypeManager                                                      \
&&                                                                      \
export TypeWorker                                                       \
&&                                                                      \
export username                                                         \
                                                                        ;
#########################################################################
path=$AWS/bin                                                           \
&&                                                                      \
file=init.sh                                                            \
&&                                                                      \
date=$( date +%F_%H%M )                                                 \
&&                                                                      \
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
path=$AWS/install/AMI/bin                                               \
&&                                                                      \
file=init-blue.sh                                                       \
&&                                                                      \
date=$( date +%F_%H%M )                                                 \
&&                                                                      \
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
path=$AWS/install/AMI/bin                                               \
&&                                                                      \
file=init-green.sh                                                      \
&&                                                                      \
date=$( date +%F_%H%M )                                                 \
&&                                                                      \
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


