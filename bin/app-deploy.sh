#!/bin/bash -x
#	./bin/app-deploy.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$A"                    && export A                 || exit 100 ;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 100 ;
test -n "$domain"               && export domain            || exit 100 ;
#########################################################################
test -n "$apps"			|| exit 100				;
test -n "$branch_app"		|| exit 100				;
test -n "$debug"		|| exit 100				;
test -n "$deploy_file"		|| exit 100				;
test -n "$deploy_path"		|| exit 100				;
test -n "$mode"			|| exit 100				;
test -n "$repository_app"	|| exit 100				;
test -n "$stack"		|| exit 100				;
test -n "$username_app"		|| exit 100				;
#########################################################################
apps=$(									\
  encode_string "$apps"							\
)									;
export=" 								\
  export debug=$debug 							\
"									;
file=$deploy_file							;
path=$deploy_path							;
targets=" 								\
  InstanceMaster1 							\
"			 						;
#########################################################################
sleep=10								;
#########################################################################
export=" 								\
  $export 								\
  &&									\
  export A=$A								\
  &&									\
  export apps=$apps							\
  &&									\
  export branch_app=$branch_app						\
  &&									\
  export branch_docker_aws=$branch_docker_aws				\
  &&									\
  export domain=$domain							\
  &&									\
  export mode=$mode							\
  &&									\
  export repository_app=$repository_app					\
  &&									\
  export username_app=$username_app					\
"									;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets" ;
#########################################################################
