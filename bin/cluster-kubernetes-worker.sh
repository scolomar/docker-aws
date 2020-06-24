#!/bin/bash -x
#	./bin/cluster-kubernetes-worker.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug"                || exit 100                             ;
test -n "$kube"    		|| exit 100                             ;
test -n "$log"                	|| exit 100                             ;
test -n "$token_discovery"      || exit 100                             ;
test -n "$token_token"          || exit 100                             ;
#########################################################################
token_discovery="$(							\
	echo								\
		$token_discovery					\
	|								\
	base64								\
		--decode						\
)"							         	;
token_token="$(								\
	echo								\
		$token_token						\
	|								\
	base64								\
		--decode						\
)"							         	;
#########################################################################
compose=etc/docker/swarm/docker-compose.yaml				;
uuid=$( uuidgen )							;
#########################################################################
git clone 								\
	--single-branch --branch v1.0					\
	https://github.com/secobau/nlb 					\
	$uuid								;
sed --in-place s/worker/manager/ $uuid/$compose				;
sudo cp --recursive --verbose $uuid/run/* /run				;
docker swarm init							;
docker stack deploy --compose-file $uuid/$compose nlb			;
while true								;
do									\
  sleep 1								;
  docker service ls | grep '\([0-9]\)/\1' && break			;
done									;
sudo rm --recursive --force /run/secrets /run/configs			;
sed --in-place 								\
	/$kube/d 							\
	/etc/hosts   		                                  	;
sed --in-place 								\
	/localhost4/s/$/' '$kube/ 					\
	/etc/hosts          				             	;
#########################################################################
while true								;
do									\
        systemctl							\
		is-enabled						\
			kubelet                               		\
	|								\
	grep enabled    	                                      	\
	&& break							\
                                                                        ;
done									;	
#########################################################################
$token_token                                            		\
	$token_discovery                                        	\
	--ignore-preflight-errors					\
		all							\
	2>&1								\
	|								\
	tee $log							\
									;
#########################################################################
