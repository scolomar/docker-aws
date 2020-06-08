#!/bin/bash -x
#	./bin/app-init-config-deploy.sh
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
test -n "$apps"                 && export apps           || exit ${EX_USAGE};
test -n "$A"	                && export A            	 || exit ${EX_USAGE};
test -n "$branch_app"           && export branch_app     || exit ${EX_USAGE};
test -n "$debug"                && export debug          || exit ${EX_USAGE};
test -n "$domain"               && export domain         || exit ${EX_USAGE};
test -n "$mode"                 && export mode           || exit ${EX_USAGE};
test -n "$repository_app"       && export repository_app || exit ${EX_USAGE};
test -n "$stack"                && export stack          || exit ${EX_USAGE};
test -n "$username_app"         && export username_app   || exit ${EX_USAGE};
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
file=app-deploy.sh      	                                        ;
path=$A/bin                                 				;
#########################################################################
export deploy_file=app-config-deploy.sh                                 ;
export deploy_path=$path						;
#########################################################################
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
echo $output								;
#########################################################################
