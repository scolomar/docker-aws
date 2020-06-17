This project will allow you to deploy a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will first create the infrastructure in AWS. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 

#########################################################################
export branch_docker_aws=master                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=raw.githubusercontent.com                                 ;
export HostedZoneName=sebastian-colomar.com                             ;
export repository_docker_aws=docker-aws                                 ;
export stack=docker                                                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws/$branch_docker_aws ;
#########################################################################
export Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                  ;
export KeyName=cloud9_mumbai_mgmt                                       ;
export RecordSetName1=$stack-dockercoins                                ;
export RecordSetName2=$stack-petclinic                                  ;
export RecordSetName3=$stack-php                                        ;
export RecordSetNameKube=$stack-kube-apiserver                          ;
export s3name=docker-aws                                                ;
export s3region=ap-south-1                                              ;
export template=https.yaml                                              ;
export TypeMaster=t3a.micro                                             ;
export TypeWorker=t3a.micro                                             ;
export TypeMaster=t3a.nano                                              ;
export TypeWorker=t3a.nano                                              ;
#########################################################################
date=$( date +%F_%H%M )                                                 ;
file=aws-init.sh                                                        ;
path=$A/bin                                                             ;
#########################################################################
mkdir $date                                                             ;
cd $date                                                                ;
curl --output $file https://$domain/$path/$file?$( uuidgen )            ;
chmod +x ./$file                                                        ;
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



