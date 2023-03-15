#!/bin/sh -x
#	./bin/aws-node-ami.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x 	&& test "$debug" = true	&& set -x                               ;
#########################################################################
sudo yum update -y                                                      ;
sudo yum install git -y                                                 ;
sudo amazon-linux-extras install docker -y                              ;
sudo systemctl enable docker                                            ;
sudo systemctl start docker                                             ;
while true                                                              ;
do                                                                      \
  service docker status | grep running -q && break                      ;
  sleep 10                                                              ;
done                                                                    ;
#########################################################################



