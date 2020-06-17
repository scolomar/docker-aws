#!/bin/bash -x
#	./bin/cluster-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 100 ;
test -n "$debug" 		&& export debug	            || exit 100	;
test -n "$domain" 		&& export domain	    || exit 100	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 100 ;
test -n "$RecordSetNameKube"	&& export RecordSetNameKube || exit 100 ;
test -n "$repository_docker_aws"&&export repository_docker_aws||exit 100;
test -n "$mode"                 && export mode	            || exit 100	;
test -n "$stack"                && export stack	            || exit 100	;
#########################################################################
file=common-functions.sh						;
uuid=$( uuidgen )							;
#########################################################################
path=$uuid/lib                                 				;
#########################################################################
git clone                                                               \
        --single-branch --branch $branch_docker_aws                     \
        https://$domain/$A                                              \
        $uuid                                                           \
                                                                        ;
chmod +x $path/$file                                                    ;
source ./$path/$file                                                    ;
rm --force --recursive $uuid                                            ;
#########################################################################
export -f encode_string							;
export -f exec_remote_file						;
export -f send_command							;
export -f send_list_command						;
export -f send_remote_file						;
export -f send_wait_targets						;
export -f service_wait_targets						;
#########################################################################
file=cluster-$mode-init.sh						;
path=bin								;
exec_remote_file $domain $file $path					;
#########################################################################
