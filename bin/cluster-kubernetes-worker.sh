#!/bin/bash -x
#	./bin/cluster-kubernetes-worker.sh
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
test -n "$HostedZoneName"       || exit ${EX_USAGE}			;
test -n "$RecordSetNameKube"    || exit ${EX_USAGE}			;
test -n "$log"                	|| exit ${EX_USAGE}			;
test -n "$token_discovery"      || exit ${EX_USAGE}			;
test -n "$token_token"          || exit ${EX_USAGE}			;
#########################################################################
kube=$RecordSetNameKube.$HostedZoneName					;
#########################################################################
token_discovery="$(							\
	echo								\
		$token_discovery					\
	|								\
		base64							\
			--decode					\
)"							         	;
token_token="$(								\
	echo								\
		$token_token						\
	|								\
		base64							\
			--decode					\
)"							         	;
#########################################################################
echo $ip $kube | tee --append /etc/hosts                           	;
#########################################################################
while true								;
do									\
        systemctl							\
		is-enabled						\
			kubelet                               		\
	|								\
		grep enabled                                          	\
		&& break						\
                                                                        ;
done									;	
#########################################################################
$token_token                                            		\
	$token_discovery                                        	\
	--ignore-preflight-errors					\
		all							\
	2>&1								\
	|								\
		tee $log						\
									;
#########################################################################
