This project will allow you to deploy a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will first create the infrastructure in AWS. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
debug=false                                                             \
debug=true                                                              \
branch_docker_aws=master                                                \
docker_repository=docker-aws                                            \
docker_username=secobau                                                 \
domain=raw.githubusercontent.com                                        \
HostedZoneName=sebastian-colomar.com                                    \
Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                         \
KeyName=proxy2aws                                                       \
mode=kubernetes                                                         \
mode=swarm                                                              \
RecordSetName1=aws2cloud                                                \
RecordSetName2=aws2prem                                                 \
RecordSetName3=service-3                                                \
s3name=docker-aws                                                       \
s3region=ap-south-1                                                     \
stack=proxy2aws                                                         \
template=https.yaml                                                     \
TypeManager=t3a.nano                                                    \
TypeWorker=t3a.nano                                                     \
                                                                        ;
#########################################################################
export AWS=$docker_username/$docker_repository/$branch_docker_aws       \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export branch_docker_aws                                                \
&&                                                                      \
export docker_repository                                                \
&&                                                                      \
export domain                                                           \
&&                                                                      \
export HostedZoneName                                                   \
&&                                                                      \
export Identifier                                                       \
&&                                                                      \
export KeyName                                                          \
&&                                                                      \
export RecordSetName1                                                   \
&&                                                                      \
export RecordSetName2                                                   \
&&                                                                      \
export RecordSetName3                                                   \
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
                                                                        ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-init.sh                                                        \
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



