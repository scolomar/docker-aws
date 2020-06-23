#!/bin/bash -x
#	./bin/init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 100 ;
test -n "$apps" 		&& export apps	            || exit 100	;
test -n "$branch_app" 	        && export branch_app	    || exit 100	;
test -n "$branch_docker_aws"    && export branch_docker_aws || exit 100 ;
test -n "$debug" 		&& export debug	            || exit 100	;
test -n "$domain" 		&& export domain	    || exit 100	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 100 ;
test -n "$Identifier"		&& export Identifier        || exit 100 ;
test -n "$KeyName"              && export KeyName	    || exit 100	;
test -n "$mode"                 && export mode	            || exit 100	;
test -n "$repository_app"       && export repository_app    || exit 100	;
test -n "$RecordSetName1"	&& export RecordSetName1    || exit 100 ;
test -n "$RecordSetName2"	&& export RecordSetName2    || exit 100 ;
test -n "$RecordSetName3"	&& export RecordSetName3    || exit 100 ;
test -n "$RecordSetNameKube"	&& export RecordSetNameKube || exit 100 ;
test -n "$s3name"		&& export s3name    	    || exit 100 ;
test -n "$s3region"		&& export s3region    	    || exit 100 ;
test -n "$stack"                && export stack	            || exit 100	;
test -n "$template"		&& export template    	    || exit 100 ;
test -n "$TypeMaster"		&& export TypeMaster 	    || exit 100 ;
test -n "$TypeWorker"		&& export TypeWorker 	    || exit 100 ;
test -n "$username_app"         && export username_app	    || exit 100	;
#########################################################################
file=common-functions.sh						;
path=lib								;
#########################################################################
chmod +x $path/$file                                                    ;
source ./$path/$file                                                    ;
#########################################################################
file=aws-init.sh                                               		;
path=bin								;
#########################################################################
exec_remote_file $domain $file $path				        ;
#########################################################################
file=cluster-init.sh							;
#########################################################################
exec_remote_file $domain $file $path			        	;
#########################################################################
file=app-init.sh                                               		;
#########################################################################
exec_remote_file $domain $file $path		        		;
#########################################################################
