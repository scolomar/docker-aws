#!/bin/bash -x
#	./bin/init.sh
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
test -n "$A"	                && export A                 || exit ${EX_USAGE};
test -n "$apps" 		&& export apps	            || exit ${EX_USAGE};
test -n "$branch_app" 	        && export branch_app	    || exit ${EX_USAGE};
test -n "$branch_docker_aws"    && export branch_docker_aws || exit ${EX_USAGE};
test -n "$debug" 		&& export debug	            || exit ${EX_USAGE};
test -n "$domain" 		&& export domain	    || exit ${EX_USAGE};
test -n "$HostedZoneName"	&& export HostedZoneName    || exit ${EX_USAGE};
test -n "$Identifier"		&& export Identifier        || exit ${EX_USAGE};
test -n "$KeyName"              && export KeyName	    || exit ${EX_USAGE};
test -n "$mode"                 && export mode	            || exit ${EX_USAGE};
test -n "$repository_app"       && export repository_app    || exit ${EX_USAGE};
test -n "$RecordSetName1"	&& export RecordSetName1    || exit ${EX_USAGE};
test -n "$RecordSetName2"	&& export RecordSetName2    || exit ${EX_USAGE};
test -n "$RecordSetName3"	&& export RecordSetName3    || exit ${EX_USAGE};
test -n "$RecordSetNameKube"	&& export RecordSetNameKube || exit ${EX_USAGE};
test -n "$s3name"		&& export s3name    	    || exit ${EX_USAGE};
test -n "$s3region"		&& export s3region    	    || exit ${EX_USAGE};
test -n "$stack"                && export stack	            || exit ${EX_USAGE};
test -n "$template"		&& export template    	    || exit ${EX_USAGE};
test -n "$TypeManager"		&& export TypeManager 	    || exit ${EX_USAGE};
test -n "$TypeWorker"		&& export TypeWorker 	    || exit ${EX_USAGE};
test -n "$username_app"         && export username_app	    || exit ${EX_USAGE};
#########################################################################
file=common-functions.sh						;
path=$A/lib								;
uuid=$( uuidgen )							;
#########################################################################
curl --output $uuid https://$domain/$path/$file?$( uuidgen )            ;
source ./$uuid                                                          ;
rm --force ./$uuid							;
#########################################################################
export -f encode_string							;
export -f exec_remote_file						;
export -f send_command							;
export -f send_list_command						;
export -f send_remote_file						;
export -f send_wait_targets						;
export -f service_wait_targets						;
#########################################################################
path=$A/bin								;
#########################################################################
file=aws-init.sh                                               		;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
echo $output								;
#########################################################################
file=cluster-init.sh							;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
echo $output								;
#########################################################################
file=app-init.sh                                               		;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
echo $output								;
#########################################################################
