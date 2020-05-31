This project will allow you to deploy a containerized application in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.


The following script will first create the infrastructure and then deploy your application. 
In order to customize the setup you should modify the variables in this page and also in the following folder:
```BASH
./etc/docker-aws/
```

You need to run the following commands from a terminal with enough AWS privileges:

```BASH



#########################################################################
export branch_docker_aws=master                                                \
debug=false                                                             \
debug=true                                                              \
domain=raw.githubusercontent.com                                        \
HostedZoneName=sebastian-colomar.com                                    \
mode=kubernetes                                                         \
mode=swarm                                                              \
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
export mode                                                             \
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
export apps=" dockercoins.yaml petclinic.yaml php.yaml "                ;
export branch_app=master                                                ;
export repository_app=docker-aws                                        ;
export username_app=secobau                                             ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=init.sh                                                            \
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


You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:


```BASH



#########################################################################
## TO REMOVE THE CLOUDFORMATION STACK                                   #
aws cloudformation delete-stack --stack-name $stack                     ;
#########################################################################



```



