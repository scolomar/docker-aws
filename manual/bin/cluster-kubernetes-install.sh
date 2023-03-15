#!/bin/bash -x
#	./bin/cluster-kubernetes-install.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
file=kubernetes.repo                                                    ;
repos=yum.repos.d							;
#########################################################################
uuid=/tmp/$( uuidgen )							;
#########################################################################
path=$uuid/etc/$repos							;
#########################################################################
git clone                                                               \
        --single-branch --branch manual                                 \
        https://github.com/secobau/docker-aws                           \
        $uuid                                                           \
                                                                        ;
sudo mv $path/$file /etc/$repos/$file                                   ;
rm --recursive --force $uuid                                            ;
#########################################################################
sudo yum install                                                        \
        --assumeyes                                                     \
        --disableexcludes=kubernetes                                    \
        kubelet-1.18.4-1                                                \
        kubeadm-1.18.4-1                                                \
        kubectl-1.18.4-1                                                \
                                                                        ;
sudo systemctl enable                                                   \
        --now                                                           \
        kubelet                                                         \
                                                                        ;
#########################################################################
sudo kubeadm config images pull                                         ;
#########################################################################


