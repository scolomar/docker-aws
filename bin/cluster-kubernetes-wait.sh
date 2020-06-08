#!/bin/bash -x
#	./bin/cluster-kubernetes-wait.sh
################################################################################
##       Copyright (C) 2020        Sebastian Francisco Colomar Bauza          ##
##       Copyright (C) 2020        Alejandro Colomar Andrés                   ##
##       SPDX-License-Identifier:  GPL-2.0-only                               ##
################################################################################


################################################################################
##	source								      ##
################################################################################
source	lib/libalx/sh/sysexits.sh


#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug"                || exit ${EX_USAGE}			;
#########################################################################
kubeconfig=/etc/kubernetes/admin.conf                   		;
sleep=10								;
#########################################################################
USER=ssm-user								;
HOME=/home/$USER							;
while true								;
do									\
  test -f $HOME/.kube/config						\
  &&									\
  break									\
									;
  sleep $sleep								;
done									;	
#########################################################################
while true								;
do									\
  kubectl get node							\
    --kubeconfig $kubeconfig						\
  |									\
    grep Ready								\
    |									\
      grep --invert-match NotReady					\
      &&								\
      break								\
									;
  sleep $sleep								;
done									;
#########################################################################
sed --in-place /kube/d /etc/hosts                                     	;
#########################################################################
