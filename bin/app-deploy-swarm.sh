#!/bin/bash -x
#	./bin/app-deploy-swarm.sh
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
test -n "$domain"		|| exit ${EX_USAGE}			;
test -n "$mode"			|| exit ${EX_USAGE}			;
test -n "$repository_app"	|| exit ${EX_USAGE}			;
test -n "$username_app"		|| exit ${EX_USAGE}			;
#########################################################################
apps="									\
  $(                                                   			\
    echo								\
      $apps                                      			\
    |                                                               	\
      base64                                                  		\
        --decode                                        		\
  )									\
"                                                                      	;
path=$username_app/$repository_app/$branch_app/etc/docker/$mode		;
#########################################################################
for app in $apps							;
do 									\
  prefix=$( echo $app | cut --delimiter . --field 1 )			;
  suffix=$( echo $app | cut --delimiter . --field 2 )			;
  for name in $prefix							;
  do									\
    uuid=$( uuidgen )							;
    curl --output $uuid https://$domain/$path/$name.$suffix?$( uuidgen );
    docker stack deploy --compose-file $uuid $name 			;
    rm --force $uuid							;
  done									;
done									;
#########################################################################
docker stack ls								;
docker service ls							;
#########################################################################
