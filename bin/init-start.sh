#!/bin/bash -x
#	./bin/init-start.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export branch_docker_aws=master                                         ;
export debug=false                                                      ;
export debug=true                                                       ;
export domain=github.com                                                ;
export HostedZoneName=sebastian-colomar.com                             ;
export mode=swarm                                                       ;
export mode=kubernetes                                                  ;
export repository_docker_aws=docker-aws                                 ;
export stack=${repository_docker_aws}-$( date +%s )                     ;
export username_docker_aws=secobau                                      ;
#########################################################################
export A=$username_docker_aws/$repository_docker_aws                    ;
#########################################################################
export Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                  ;
export KeyName=cloud9_mumbai_mgmt                                       ;
export RecordSetName1=${stack}-dockercoins                              ;
export RecordSetName2=${stack}-petclinic                                ;
export RecordSetName3=${stack}-php                                      ;
export RecordSetNameKube=${stack}-kube-apiserver                        ;
export s3name=docker-aws                                                ;
export s3region=ap-south-1                                              ;
export template=https.yaml                                              ;
export TypeMaster=t3a.nano                                              ;
export TypeMaster=t3a.micro                                             ;
export TypeWorker=t3a.micro                                             ;
export TypeWorker=t3a.nano                                              ;
#########################################################################
export apps=""                                                          ;
export apps=" $apps dockercoins.yaml "                                  ;
export apps=" $apps petclinic.yaml "                                    ;
export apps=""                                                          ;
export apps=" $apps php.yaml "                                          ;
export branch_app=master                                                ;
export repository_app=docker-aws                                        ;
export username_app=secobau                                             ;
#########################################################################
file=init.sh                                                            ;
path=bin                                                                ;
#########################################################################
./$path/$file                                                           ;
#########################################################################
