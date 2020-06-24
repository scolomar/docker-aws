#!/bin/bash -x
#	./bin/cluster-kubernetes-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"			|| exit 100				;
test -n "$branch_docker_aws"	|| exit 100				;
test -n "$debug"		|| exit 100				;
test -n "$domain"		|| exit 100				;
test -n "$HostedZoneName"	|| exit 100				;
test -n "$RecordSetNameKube"	|| exit 100				;
test -n "$stack"		|| exit 100				;
#########################################################################
export=" 								\
  export debug=$debug 							\
"									;
log=/tmp/kubernetes-install.log                              		;
path=bin								;
sleep=10								;
#########################################################################
export=" 								\
  $export								\
  && 									\
  export A=$A								\
  && 									\
  export branch_docker_aws=$branch_docker_aws				\
  && 									\
  export domain=$domain							\
"									;
file=cluster-kubernetes-install.sh					;
targets="								\
	InstanceMaster1							\
	InstanceMaster2							\
	InstanceMaster3							\
	InstanceWorker1							\
	InstanceWorker2							\
	InstanceWorker3							\
"									;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets"	;
#########################################################################
export=" 								\
  $export								\
  && 									\
  export HostedZoneName=$HostedZoneName					\
  && 									\
  export log=$log							\
  && 									\
  export RecordSetNameKube=$RecordSetNameKube				\
"									;
targets="								\
	InstanceMaster1							\
"									;
#########################################################################
file=cluster-kubernetes-leader.sh					;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets"	;
#########################################################################
file=cluster-kubernetes-wait.sh						;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets"	;
#########################################################################
command="								\
	grep --max-count 1						\
		certificate-key						\
		$log							\
"									;
token_certificate=$(							\
  encode_string "							\
    $(									\
      send_wait_targets "$command" $sleep $stack "$targets"		\
    )									\
  "									;	
)									;
#########################################################################
command="								\
	grep --max-count 1						\
		discovery-token-ca-cert-hash				\
		$log							\
"									;
token_discovery=$(							\
  encode_string "							\
    $(									\
      send_wait_targets "$command" $sleep $stack "$targets"		\
    )									\
  "									;	
)									;
#########################################################################
command="								\
	grep --max-count 1						\
		kubeadm.*join						\
		$log							\
"									;
token_token=$(								\
  encode_string "							\
    $(									\
      send_wait_targets "$command" $sleep $stack "$targets"		\
    )									\
  "									;	
)									;
#########################################################################
export=" 								\
  $export								\
  &&									\
  export token_certificate=$token_certificate				\
  &&									\
  export token_discovery=$token_discovery				\
  &&									\
  export token_token=$token_token					\
"									;
file=cluster-kubernetes-manager.sh					;
targets="								\
	InstanceMaster2							\
	InstanceMaster3							\
"									;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets"	;
#########################################################################
unset token_certificate							;
#########################################################################
export=" 								\
  $export								\
"									;
file=cluster-kubernetes-worker.sh					;
targets="								\
	InstanceWorker1							\
	InstanceWorker2							\
	InstanceWorker3							\
"									;
send_remote_file $domain "$export" $file $path $sleep $stack "$targets"	;
#########################################################################
