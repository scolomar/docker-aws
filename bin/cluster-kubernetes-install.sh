#!/bin/bash -x
#	./bin/cluster-kubernetes-install.sh
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
test -n "$A" 		        || exit ${EX_USAGE}			;
test -n "$debug" 		|| exit ${EX_USAGE}			;
test -n "$domain"               || exit ${EX_USAGE}			;
#########################################################################
file=kubernetes.repo							;
repos=yum.repos.d							;
#########################################################################
path=$A/etc/$repos							;
uuid=$( uuidgen )							;
curl --output $uuid https://$domain/$path/$file?$( uuidgen )            ;
mv $uuid /etc/$repos/$file						;
#########################################################################
yum install								\
	--assumeyes							\
	--disableexcludes=kubernetes					\
	kubelet								\
	kubeadm								\
	kubectl								\
									;
systemctl enable							\
	--now								\
	kubelet								\
									;
#########################################################################
