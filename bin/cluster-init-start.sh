#!/bin/bash -x
#	./bin/cluster-init-start.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export branch_docker_aws=master                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=raw.githubusercontent.com                                 ;
export HostedZoneName=sebastian-colomar.com                             ;
export mode=kubernetes                                                  ;
export mode=swarm                                                       ;
export RecordSetNameKube=$stack-kube-apiserver                          ;
export repository_docker_aws=docker-aws                                 ;
export stack=master                                                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws/$branch_docker_aws ;
#########################################################################
date=$( date +%F_%H%M )                                                 ;
file=cluster-init.sh                                                    ;
path=$A/bin                                                             ;
#########################################################################
mkdir $date                                                             ;
cd $date                                                                ;
curl --output $file https://$domain/$path/$file?$( uuidgen )            ;
chmod +x ./$file                                                        ;
nohup ./$file                                                           ;
rm --force ./$file                                                      ;
#########################################################################
