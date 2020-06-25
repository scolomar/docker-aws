#!/bin/bash -x
#	./bin/cluster-init-start.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export branch_docker_aws=v6.0                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=github.com                                                ;
export HostedZoneName=sebastian-colomar.com                             ;
export mode=swarm                                                       ;
export mode=kubernetes                                                  ;
export RecordSetNameKube=$stack-kube-apiserver                          ;
export repository_docker_aws=docker-aws                                 ;
export stack=${repository_docker_aws}-$( date +%s )                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws			;
#########################################################################
file=cluster-init.sh                                                    ;
path=bin                                                                ;
#########################################################################
./$path/$file                                                           ;
#########################################################################
