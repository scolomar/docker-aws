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
test -n "$repository_docker_aws"|| exit 100				;
test -n "$username_app"		|| exit 100				;
#########################################################################
apps="									\
  $(                                                   			\
    echo								\
      $apps                                      			\
    |                                                               	\
    base64                                                  		\
      --decode                                        			\
  )									\
"                                                                      	;
B=$username_app/$repository_app                                         ;
path=docker/$mode							;
uuid=$( uuidgen )                                                       ;
#########################################################################
git clone                                                               \
  --single-branch --branch $branch_app                                  \
  https://$domain/$B                                                    \
  $uuid                                                                 \
                                                                        ;
for app in $apps							;
do 									\
  prefix=$( echo $app | cut --delimiter . --field 1 )			;
  suffix=$( echo $app | cut --delimiter . --field 2 )			;
  for name in $prefix							;
  do									\
    filename=$uuid/$path/$name.$suffix                                  ;
    docker stack deploy --compose-file $filename $name 			;
  done									;
done									;
rm --force --recursive $uuid                                            ;
#########################################################################
docker stack ls								;
docker service ls							;
#########################################################################
