#!/bin/bash -x
#        ./bin/app-deploy-kubernetes.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x                                ;
#########################################################################
apps="                                                                  \
        phpinfo.yaml                                                    \
"                                                                       ;
branch_app=manual                                                       ;
domain=github.com                                                       ;
mode=kubernetes                                                         ;
repository_app=docker-aws                                               ;
username_app=secobau                                                    ;
#########################################################################
B=$username_app/$repository_app                                         ;
path=etc/docker/$mode                                                   ;
uuid=/tmp/$( uuidgen )                                                  ;
#########################################################################
kubeconfig=/etc/kubernetes/admin.conf                                   ;
#########################################################################
git clone                                                               \
        --single-branch --branch $branch_app                            \
        https://$domain/$B                                              \
        $uuid                                                           \
                                                                        ;
for app in $apps                                                        ;
do                                                                      \
        prefix=$( echo $app | cut --delimiter . --field 1 )             ;
        suffix=$( echo $app | cut --delimiter . --field 2 )             ;
        for name in $prefix                                             ;
        do                                                              \
                filename=$uuid/$path/$name.$suffix                      ;
                while true                                              ;
                do                                                      \
                        kubectl apply --filename $filename              ;
                        kubectl get deployment                          \
                        |                                               \
                        grep '\([0-9]\)/\1' && break                    ;
                        sleep 10                                        ;
                done                                                    ;
        done                                                            ;
done                                                                    ;
rm --force --recursive $uuid                                            ;
#########################################################################
for resource in node service pod                                        ;
do                                                                      \
        kubectl get                                                     \
                $resource                                               ;
done                                                                    ;
#########################################################################
