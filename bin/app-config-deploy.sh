#!/bin/bash -x
#	./bin/app-config-deploy.sh
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
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$branch_app"		|| exit ${EX_USAGE}			;
test -n "$debug"		|| exit ${EX_USAGE}			;
test -n "$repository_app"	|| exit ${EX_USAGE}			;
test -n "$username_app"		|| exit ${EX_USAGE}			;
#########################################################################
folders=" configs secrets " 						;
umask_new=0077								;
umask_old=$( umask ) 							;
#########################################################################
umask $umask_new							;
uuid=$( uuidgen )							;
git clone --single-branch --branch $branch_app				\
  https://github.com/$username_app/$repository_app /root/$uuid		;
for folder in $folders 							;
do 									\
  cp --recursive --verbose /root/$uuid/run/$folder /run  		;
done 									;
rm --recursive --force /root/$uuid 		 			;
umask $umask_old							;
#########################################################################
