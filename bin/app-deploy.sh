#!/bin/bash -x
#	./bin/app-deploy.sh
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
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$apps"			|| exit ${EX_USAGE}			;
test -n "$branch_app"		|| exit ${EX_USAGE}			;
test -n "$debug"		|| exit ${EX_USAGE}			;
test -n "$deploy_file"		|| exit ${EX_USAGE}			;
test -n "$deploy_path"		|| exit ${EX_USAGE}			;
test -n "$domain"		|| exit ${EX_USAGE}			;
test -n "$mode"			|| exit ${EX_USAGE}			;
test -n "$repository_app"	|| exit ${EX_USAGE}			;
test -n "$stack"		|| exit ${EX_USAGE}			;
test -n "$username_app"		|| exit ${EX_USAGE}			;
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
  InstanceManager1 							\
"			 						;
#########################################################################
sleep=10								;
#########################################################################
export=" 								\
  $export 								\
  &&									\
  export apps=$apps							\
  &&									\
  export branch_app=$branch_app						\
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
