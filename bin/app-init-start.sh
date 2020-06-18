#!/bin/bash -x
#	./bin/app-init-start.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export branch_docker_aws=master                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=github.com                                                ;
export mode=kubernetes                                                  ;
export mode=swarm                                                       ;
export repository_docker_aws=docker-aws                                 ;
export stack=master                                                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws			;
#########################################################################
export apps=""                                                          ;
export apps=" $apps dockercoins.yaml "                                  ;
export apps=" $apps petclinic.yaml "                                    ;
export apps=" $apps php.yaml "                                          ;
export branch_app=master                                                ;
export repository_app=docker-aws                                        ;
export username_app=secobau                                             ;
#########################################################################
date=$( date +%F_%H%M )                                                 ;
file=app-init.sh                                                        ;
uuid=$( uuidgen )							;
#########################################################################
path=$uuid/bin								;
#########################################################################
mkdir $date                                                             ;
cd $date                                                                ;
git clone 								\
	--single-branch --branch $branch_docker_aws			\
	https://$domain/$A 						\
	$uuid								\
									;
chmod +x $path/$file                                                    ;
nohup ./$path/$file                                                     ;
rm --force --recursive $uuid						;
#########################################################################
