#!/bin/bash -x
#	./bin/aws-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 100 ;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 100 ;
test -n "$debug" 		&& export debug	            || exit 100	;
test -n "$domain" 		&& export domain	    || exit 100	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 100 ;
test -n "$Identifier"		&& export Identifier        || exit 100 ;
test -n "$KeyName"              && export KeyName	    || exit 100	;
test -n "$RecordSetName1"	&& export RecordSetName1    || exit 100 ;
test -n "$RecordSetName2"	&& export RecordSetName2    || exit 100 ;
test -n "$RecordSetName3"	&& export RecordSetName3    || exit 100 ;
test -n "$RecordSetNameKube"	&& export RecordSetNameKube || exit 100 ;
test -n "$repository_docker_aws"&&export repository_docker_aws||exit 100;
test -n "$s3name"		&& export s3name    	    || exit 100 ;
test -n "$s3region"		&& export s3region    	    || exit 100 ;
test -n "$stack"                && export stack	            || exit 100	;
test -n "$template"		&& export template    	    || exit 100 ;
test -n "$TypeMaster"		&& export TypeMaster 	    || exit 100 ;
test -n "$TypeWorker"		&& export TypeWorker 	    || exit 100 ;
#########################################################################
BranchDockerAWS=$branch_docker_aws					;
caps=CAPABILITY_IAM							;
NodeInstallUrlPath=https://$domain/$A					;
s3domain=$s3name.s3.$s3region.amazonaws.com				;
template_url=https://$s3domain/$branch_docker_aws/$template		;
uuid=$( uuidgen )							;
#########################################################################
path=$uuid/etc/aws							;
#########################################################################
git clone                                                               \
        --single-branch --branch $branch_docker_aws                     \
        https://$domain/$A                                              \
        $uuid                                                           \
                                                                        ;
aws s3 cp $path/$template s3://$s3name/$branch_docker_aws/$template	;
rm --force --recursive ./$uuid						;
#########################################################################
while true                                                              ;
do                                                                      \
  aws s3 ls $s3name/$branch_docker_aws/$template                        \
  |                                                                     \
  grep $template && break                                               ;
  sleep 10                                                              ;
done                                                                    ;
#########################################################################
aws cloudformation create-stack 					\
  --capabilities 							\
    $caps 								\
  --parameters 								\
    ParameterKey=BranchDockerAWS,ParameterValue=$BranchDockerAWS	\
    ParameterKey=HostedZoneName,ParameterValue=$HostedZoneName		\
    ParameterKey=InstanceMasterInstanceType,ParameterValue=$TypeMaster	\
    ParameterKey=InstanceWorkerInstanceType,ParameterValue=$TypeWorker  \
    ParameterKey=Identifier,ParameterValue=$Identifier			\
    ParameterKey=KeyName,ParameterValue=$KeyName			\
    ParameterKey=NodeInstallUrlPath,ParameterValue=$NodeInstallUrlPath	\
    ParameterKey=RecordSetName1,ParameterValue=$RecordSetName1		\
    ParameterKey=RecordSetName2,ParameterValue=$RecordSetName2		\
    ParameterKey=RecordSetName3,ParameterValue=$RecordSetName3		\
    ParameterKey=RecordSetNameKube,ParameterValue=$RecordSetNameKube	\
  --stack-name 								\
    $stack 								\
  --template-url 						 	\
    $template_url							\
  --output 								\
    text 								\
									;
#########################################################################
while true 								;
do 									\
  aws cloudformation describe-stacks 					\
    --query 								\
      "Stacks[].StackStatus" 						\
    --output 								\
      text 								\
    --stack-name 							\
      $stack 								\
  | 									\
  grep CREATE_COMPLETE && break 					;
  sleep 100 								;
done									;
#########################################################################
