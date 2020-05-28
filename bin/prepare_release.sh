#!/bin/sh -x
#	./bin/prepare_release.sh
################################################################################
##	Copyright (C) 2020	  Alejandro Colomar Andrés		      ##
##	Copyright (C) 2020	  Sebastian Francisco Colomar Bauza	      ##
##	SPDX-License-Identifier:  GPL-2.0-only				      ##
################################################################################
##
## Prepare the repo for release
## ============================
##
##  - Remove the files that shouldn't go into the release
##  - Update version numbers
##
################################################################################


################################################################################
##	functions							      ##
################################################################################
update_version()
{
	local	version=$1
	local	old_version=v2.3
	local	template=https.yaml

	local	template_local=./etc/aws/$template
	sed "/branch_docker_aws=/s/$old_version/$version/"		\
			-i ./README-app.md				\
			-i ./README-aws.md				\
			-i ./README-cluster.md				\
			-i ./README-demo.md				\
			-i ./README.md
	sed "/docker-aws/s/$old_version/$version/"			\
			-i $template_local
	sed "/old_version/s/$old_version/$version/"			\
			-i ./bin/prepare_release.sh
}


################################################################################
##	main								      ##
################################################################################
main()
{
	local	version=$1

	update_version	${version}
}


################################################################################
##	run								      ##
################################################################################
main	$1


################################################################################
##	end of file							      ##
################################################################################
