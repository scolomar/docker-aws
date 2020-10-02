This project will allow you to deploy a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

The following script will first create the infrastructure in AWS. You need to run the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:
* [AWS configuration](etc/conf.d/aws.conf)

Afterwards you can run the script to automatically create the infrastructure in AWS:
* [AWS installation script](bin/aws-init-start.sh)

```BASH 

#########################################################################
./bin/aws-init-start.sh                                                 ;
#########################################################################



```
You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:
```BASH


#########################################################################
## TO REMOVE THE CLOUDFORMATION STACK                                   #
aws cloudformation delete-stack --stack-name $stack                     ;
#########################################################################


```



