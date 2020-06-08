#!/bin/bash -x
#	./bin/aws-target-green.sh
################################################################################
##       Copyright (C) 2020        Sebastian Francisco Colomar Bauza          ##
##       Copyright (C) 2020        Alejandro Colomar Andrés                   ##
##       SPDX-License-Identifier:  GPL-2.0-only                               ##
################################################################################


################################################################################
##	source								      ##
################################################################################
source	lib/libalx/sh/sysexits.sh


#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit ${EX_USAGE};
test -n "$branch_docker_aws"    && export branch_docker_aws || exit ${EX_USAGE};
test -n "$debug" 		&& export debug	            || exit ${EX_USAGE};
test -n "$domain" 		&& export domain	    || exit ${EX_USAGE};
test -n "$HostedZoneName"	&& export HostedZoneName    || exit ${EX_USAGE};
test -n "$Identifier"		&& export Identifier        || exit ${EX_USAGE};
test -n "$KeyName"              && export KeyName	    || exit ${EX_USAGE};
test -n "$RecordSetName1"	&& export RecordSetName1    || exit ${EX_USAGE};
test -n "$RecordSetName2"	&& export RecordSetName2    || exit ${EX_USAGE};
test -n "$RecordSetName3"	&& export RecordSetName3    || exit ${EX_USAGE};
test -n "$RecordSetNameKube"	&& export RecordSetNameKube || exit ${EX_USAGE};
test -n "$s3name"		&& export s3name    	    || exit ${EX_USAGE};
test -n "$s3region"		&& export s3region    	    || exit ${EX_USAGE};
test -n "$stack"                && export stack	            || exit ${EX_USAGE};
test -n "$template"		&& export template    	    || exit ${EX_USAGE};
test -n "$TypeManager"		&& export TypeManager 	    || exit ${EX_USAGE};
test -n "$TypeWorker"		&& export TypeWorker 	    || exit ${EX_USAGE};
#########################################################################
caps=CAPABILITY_IAM							;
NodeInstallUrlPath=https://$domain/$A/bin                      		;
path=$A/etc/aws								;
s3domain=$s3name.s3.$s3region.amazonaws.com				;
template_url=https://$s3domain/$branch_docker_aws/$template		;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$template?$( uuidgen )	;
aws s3 cp $uuid s3://$s3name/$branch_docker_aws/$template 		;
rm --force ./$uuid							;
#########################################################################
while true 								;
do 									\
  aws s3 ls $s3name/$branch_docker_aws/$template			\
  |									\
    grep $template && break						;
  sleep 10 								;
done									;
#########################################################################
aws cloudformation update-stack 					\
  --capabilities 							\
    $caps 								\
  --parameters 								\
    ParameterKey=InstanceManagerInstanceType,ParameterValue=$TypeManager\
    ParameterKey=InstanceWorkerInstanceType,ParameterValue=$TypeWorker  \
    ParameterKey=HostedZoneName,ParameterValue=$HostedZoneName		\
    ParameterKey=Identifier,ParameterValue=$Identifier			\
    ParameterKey=KeyName,ParameterValue=$KeyName			\
    ParameterKey=NodeInstallUrlPath,ParameterValue=$NodeInstallUrlPath  \
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
while true                                                              ;
do                                                                      \
  aws cloudformation describe-stacks                                    \
    --query                                                             \
      "Stacks[].StackStatus"                                            \
    --output                                                            \
      text                                                              \
    --stack-name                                                        \
      $stack                                                            \
  |                                                                     \
    grep UPDATE_COMPLETE && break                                       ;
  sleep 10                                                              ;
done                                                                    ;
#########################################################################
