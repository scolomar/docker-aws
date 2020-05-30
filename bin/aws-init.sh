#!/bin/bash -x
#	./bin/aws-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$AWS"	                && export AWS               || exit 100 ;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 100 ;
test -n "$domain" 		&& export domain	    || exit 100	;
#########################################################################
file=env.conf								;
path=$AWS/etc/docker-aws						;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$file                         ;
source ./$uuid                                                          ;
rm --force ./$uuid							;
#########################################################################
caps=CAPABILITY_IAM							;
NodeInstallUrlPath=https://$domain/$AWS/bin				;
path=$AWS/etc/aws							;
s3domain=$s3name.s3.$s3region.amazonaws.com				;
template_url=https://$s3domain/$branch_docker_aws/$template		;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$template			;
aws s3 cp $uuid s3://$s3name/$branch_docker_aws/$template		;
rm --force ./$uuid							;
#########################################################################
while true                                                              ;
do                                                                      \
  aws s3 ls $s3name/$branch_docker_aws/$template                        \
  |                                                                     \
    grep $template && break                                             ;
  sleep 10                                                              ;
done                                                                    ;
#########################################################################
aws cloudformation create-stack 					\
  --capabilities 							\
    $caps 								\
  --parameters 								\
    ParameterKey=InstanceManagerInstanceType,ParameterValue=$TypeManager\
    ParameterKey=InstanceWorkerInstanceType,ParameterValue=$TypeWorker  \
    ParameterKey=HostedZoneName,ParameterValue=$HostedZoneName		\
    ParameterKey=Identifier,ParameterValue=$Identifier			\
    ParameterKey=KeyName,ParameterValue=$KeyName			\
    ParameterKey=NodeInstallUrlPath,ParameterValue=$NodeInstallUrlPath	\
    ParameterKey=RecordSetName1,ParameterValue=$RecordSetName1		\
    ParameterKey=RecordSetName2,ParameterValue=$RecordSetName2		\
    ParameterKey=RecordSetName3,ParameterValue=$RecordSetName3		\
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
