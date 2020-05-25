#!/bin/bash -x
#	./bin/app-init-config-deploy.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$apps"                 && export apps           || exit 100    ;
test -n "$AWS"	                && export AWS            || exit 100    ;
test -n "$branch"               && export branch         || exit 100    ;
test -n "$debug"                && export debug          || exit 100    ;
test -n "$deploy"               && export deploy         || exit 100    ;
test -n "$domain"               && export domain         || exit 100    ;
test -n "$mode"                 && export mode           || exit 100    ;
test -n "$repository"           && export repository     || exit 100    ;
test -n "$stack"                && export stack          || exit 100    ;
test -n "$username"             && export username       || exit 100    ;
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
file=app-deploy.sh      	                                        ;
path=$AWS/bin                                 				;
#########################################################################
export deploy_file=app-config-deploy.sh                                 ;
export deploy_path=$path						;
#########################################################################
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
