#!/bin/bash -x
#	./bin/cluster-kubernetes-install.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A" 		        || exit 100                             ;
test -n "$branch_docker_aws"	|| exit 100                             ;
test -n "$debug" 		|| exit 100                             ;
test -n "$domain"               || exit 100                             ;
#########################################################################
file=kubernetes.repo							;
repos=yum.repos.d							;
#########################################################################
uuid=$( uuidgen )							;
#########################################################################
path=$uuid/etc/$repos							;
#########################################################################
git clone                                                               \
        --single-branch --branch $branch_docker_aws                     \
        https://$domain/$A                                              \
        $uuid                                                           \
                                                                        ;
mv $path/$file /etc/$repos/$file					;
rm --recursive --force $uuid						;
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
