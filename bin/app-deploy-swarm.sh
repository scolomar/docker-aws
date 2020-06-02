#!/bin/bash -x
#	./bin/app-deploy-swarm.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$apps"			|| exit 100				;
test -n "$branch_app"		|| exit 100				;
test -n "$debug"		|| exit 100				;
test -n "$domain"		|| exit 100				;
test -n "$mode"			|| exit 100				;
test -n "$repository_app"	|| exit 100				;
test -n "$username_app"		|| exit 100				;
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
