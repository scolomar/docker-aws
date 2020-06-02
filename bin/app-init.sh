#!/bin/bash -x
#	./bin/app-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 100 ;
test -n "$apps" 		&& export apps	            || exit 100	;
test -n "$branch_app" 	        && export branch_app	    || exit 100	;
test -n "$debug" 		&& export debug	            || exit 100	;
test -n "$domain" 		&& export domain	    || exit 100	;
test -n "$mode"                 && export mode	            || exit 100	;
test -n "$repository_app"       && export repository_app    || exit 100	;
test -n "$stack"                && export stack	            || exit 100	;
test -n "$username_app"         && export username_app	    || exit 100	;
#########################################################################
file=common-functions.sh						;
path=$A/lib                                 				;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$file?$( uuidgen )            ;
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
path=$A/bin                                 				;
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
