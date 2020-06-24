#!/bin/bash -x
#	./bin/app-deploy-kubernetes.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$apps"			|| exit 100				;
test -n "$branch_app"   	|| exit 100                             ;
test -n "$debug"        	|| exit 100                             ;
test -n "$domain"       	|| exit 100                             ;
test -n "$repository_app"	|| exit 100				;
test -n "$username_app"		|| exit 100				;
#########################################################################
apps="                                                                  \
  $(                                                                    \
    echo                                                                \
      $apps                                                             \
    |                                                                   \
    base64                                                            	\
      --decode                                                        	\
  )                                                                     \
"                                                                       ;
B=$username_app/$repository_app						;
kubeconfig=/etc/kubernetes/admin.conf 					;
path=etc/docker/$mode							;
uuid=$( uuidgen )							;
#########################################################################
for config in $( find /run/configs -type f )				;
do									\
  file=$( basename $config )						;
  kubectl create configmap $file 					\
    --from-file $config 						\
    --kubeconfig $kubeconfig						\
									; 
  rm --force $config							; 
done									;
#########################################################################
for secret in $( find /run/secrets -type f )				;
do									\
  file=$( basename $secret )						;
  kubectl create secret generic $file 					\
    --from-file $secret 						\
    --kubeconfig $kubeconfig						\
									;
  rm --force $secret							; 
done									;
#########################################################################
git clone                                                               \
  --single-branch --branch $branch_app                     		\
  https://$domain/$B                                              	\
  $uuid                                                           	\
									;
for app in $apps							;
do 									\
  prefix=$( echo $app | cut --delimiter . --field 1 )			;
  suffix=$( echo $app | cut --delimiter . --field 2 )			;
  for name in $prefix							;
  do									\
    filename=$uuid/$path/$name.$suffix					;
    while true								;
    do									\
      kubectl apply --filename $filename 				\
      	--kubeconfig $kubeconfig					;
      sleep 10								;
      kubectl get deployment 						\
      	--kubeconfig $kubeconfig					\
      | 								\
      grep '\([0-9]\)/\1' && break					;
    done								;
  done									;
done									;
rm --force --recursive $uuid                                            ;
#########################################################################
for resource in node service pod					;
do									\
	kubectl get							\
		$resource						\
		--kubeconfig $kubeconfig				;
done									;
#########################################################################
