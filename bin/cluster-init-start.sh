#!/bin/bash -x
#	./bin/cluster-init-start.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export branch_docker_aws=master                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=github.com                                                ;
export HostedZoneName=sebastian-colomar.com                             ;
export mode=kubernetes                                                  ;
export mode=swarm                                                       ;
export RecordSetNameKube=$stack-kube-apiserver                          ;
export repository_docker_aws=docker-aws                                 ;
export stack=master                                                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws			;
#########################################################################
file=cluster-init.sh                                                    ;
#########################################################################
date=$( date +%F_%H%M )                                                 ;
uuid=$( uuidgen )                                                       ;
#########################################################################
path=$uuid/bin                                                          ;
#########################################################################
mkdir $date                                                             ;
cd $date                                                                ;
git clone                                                               \
        --single-branch --branch $branch_docker_aws                     \
        https://$domain/$A                                              \
        $uuid                                                           \
                                                                        ;
chmod +x $path/$file                                                    ;
nohup ./$path/$file                                                     ;
rm --force --recursive $uuid                                            ;
#########################################################################
