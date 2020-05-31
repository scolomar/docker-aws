This project will allow you to deploy a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will first create the infrastructure in AWS. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
branch_docker_aws=v4.0                                                \
debug=false                                                             \
debug=true                                                              \
domain=raw.githubusercontent.com                                        \
HostedZoneName=sebastian-colomar.com                                    \
repository_docker_aws=docker-aws                                        \
stack=docker                                                            \
username_docker_aws=secobau                                             \
                                                                        ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws/$branch_docker_aws \
&&                                                                      \
export branch_docker_aws                                                \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export domain                                                           \
&&                                                                      \
export HostedZoneName                                                   \
&&                                                                      \
export stack                                                            \
                                                                        ;
#########################################################################
export Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                  ;
export KeyName=cloud9_mumbai_mgmt                                       ;
export RecordSetName1=dockercoins                                       ;
export RecordSetName2=petclinic                                         ;
export RecordSetName3=php                                               ;
export s3name=docker-aws                                                ;
export s3region=ap-south-1                                              ;
export template=https.yaml                                              ;
export TypeManager=t3a.nano                                             ;
export TypeWorker=t3a.nano                                              ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-init.sh                                                        \
path=$A/bin                                                             \
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



