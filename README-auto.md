This project will allow you to deploy a containerized application in a cluster of your choice.


The following script will first create the infrastructure and then deploy your application. 
In order to customize the setup you should modify the variables in these files:
* [AWS configuration](etc/conf.d/aws.conf)
* [APP configuration](etc/conf.d/app.conf)

You need to run the following commands from a terminal with enough AWS privileges:
* [Fully automated script](bin/init-start.sh)

```BASH
#########################################################################
./bin/init-start.sh                                                     ;
#########################################################################
```
If you are running a BLUE/GREEN deployment the following commands could be useful.


The following command will swap the load balancer so as to point to the BLUE deployment:
* [Point to BLUE](bin/aws-target-blue-start.sh)

```BASH
#########################################################################
./bin/aws-target-blue-start.sh                                          ;
#########################################################################
```
The following command will swap back the load balancer so as to point again to the GREEN deployment:
* [Point to GREEN](bin/aws-target-green-start.sh)

```BASH
#########################################################################
./bin/aws-target-green-start.sh                                         ;
#########################################################################
```
You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:

```BASH
#########################################################################
## TO REMOVE THE CLOUDFORMATION STACK                                   #
aws cloudformation delete-stack --stack-name $stack                     ;
#########################################################################
```
