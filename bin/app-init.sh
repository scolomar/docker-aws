#!/bin/bash -x
#	./bin/app-init.sh
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
file=env-app.conf							;
path=$AWS/etc/docker-aws						;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$file                         ;
source ./$uuid                                                          ;
rm --force ./$uuid							;
#########################################################################
file=common-functions.sh						;
path=$AWS/lib                                 				;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$file                         ;
source ./$uuid                                                          ;
rm --force ./$uuid							;
#########################################################################
export -f encode_string							;
export -f exec_remote_file						;
export -f send_command							;
export -f send_list_command						;
export -f send_remote_file						;
export -f send_wait_targets						;
export -f service_wait_targets						;
#########################################################################
path=$AWS/bin                                 				;
#########################################################################
file=app-init-config-deploy.sh      	                                ;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
file=app-init-deploy.sh      	                                	;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
file=app-init-config-remove.sh      	                                ;
output="								\
  $(									\
    exec_remote_file $domain $file $path 				; 
  )									\
"									;
#########################################################################
