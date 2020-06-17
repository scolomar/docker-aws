#!/bin/bash -x
#	./bin/app-init-start.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export branch_docker_aws=master                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=raw.githubusercontent.com                                 ;
export mode=kubernetes                                                  ;
export mode=swarm                                                       ;
export repository_docker_aws=docker-aws                                 ;
export stack=master                                                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws/$branch_docker_aws ;
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
path=$A/bin                                                             ;
#########################################################################
mkdir $date                                                             ;
cd $date                                                                ;
curl --output $file https://$domain/$path/$file?$( uuidgen )            ;
chmod +x ./$file                                                        ;
nohup ./$file                                                           ;
rm --force ./$file                                                      ;
#########################################################################
