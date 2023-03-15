#!/bin/bash -x
#	./bin/cluster-swarm-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
token_worker="                                                          \
  $(                                                                    \
    sudo docker swarm init 2> /dev/null | grep token --max-count 1      \
  )                                                                     \
"                                                                       ;
echo RUN THE FOLLOWING TOKEN IN THE WORKERS                             ;
echo sudo $token_worker                                                 ;
#########################################################################
token_master="                                                          \
  $(                                                                    \
    sudo docker swarm join-token manager 2> /dev/null | grep token      \
  )                                                                     \
"                                                                       ;
echo RUN THE FOLLOWING TOKEN IN THE MASTERS                             ;
echo sudo $token_master                                                 ;
#########################################################################



