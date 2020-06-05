#!/bin/bash
###############################################################################
##       Copyright (C) 2020        Sebastian Francisco Colomar Bauza         ##
##       Copyright (C) 2020        Alejandro Colomar Andrés                  ##
##       SPDX-License-Identifier:  GPL-2.0-only                              ##
###############################################################################


## The docker-compose file has to be in this route:
## ./etc/docker/${mode}/<docker-compose>

## The init script is in this route:
## https://${domain}/${path}/${fname}
## == https://${domain}/secobau/docker/${docker_branch}/AWS/${fname}


################################################################################
##	variables							      ##
################################################################################
branch_docker_aws=v4.3
debug=<debug>			## values: true, false
domain=raw.githubusercontent.com
HostedZoneName=<example.com>
mode=<mode>			## values: kubernetes, swarm
repository_docker_aws=docker-aws
stack=<stack>
username_docker_aws=secobau
########################################
A=$username_docker_aws/$repository_docker_aws/$branch_docker_aws
########################################
## Identifier is the ID of the certificate in case you are using HTTPS
Identifier=<xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx>
KeyName=<mySSHpublicKey>
RecordSetName1=<service-1>	## subdomain 1
RecordSetName2=<service-2>
RecordSetName3=<service-3>
RecordSetNameKube=<service-kube>	## ?
s3name=docker-aws
s3region=<region>		## ap-south-1
template=https.yaml		## ?
TypeManager=<type>		## t3a.nano
TypeWorker=<type>		## t3a.nano
########################################
apps=" <docker-compose-1.yaml> <docker-compose-2.yaml> <docker-compose-3.yaml> "
branch_app=<git-branch>		## Current branch or tag
repository_app=<github-repository>
username_app=<github-username>


################################################################################
##	export								      ##
################################################################################
export branch_docker_aws
export debug
export domain
export HostedZoneName
export mode
export repository_docker_aws
export stack
export username_docker_aws
########################################
export A
########################################
export Identifier
export KeyName
export RecordSetName1
export RecordSetName2
export RecordSetName3
export RecordSetNameKube
export s3name
export s3region
export template
export TypeManager
export TypeWorker
########################################
export apps
export branch_app
export repository_app
export username_app


################################################################################
##	run								      ##
################################################################################
fpath=${A}/bin
fname=init.sh
date=$( date +%F_%H%M )
path=$HOME/.${repository_app}/var/
mkdir --parents ${path}/${date}
cd	${path}/${date}
curl --output ${fname} https://${domain}/${fpath}/${fname}?$( uuidgen )
chmod +x ./${fname}
nohup	./${fname} &


################################################################################
##	end of file							      ##
################################################################################
