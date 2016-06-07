#!/bin/bash

SRC=$1
LAMBDA_ID=lambda_$(cat $(find . -type f) | md5)

if [ ! -z $LAMBDA_ID ]
then
	DIRPATH=/tmp/$LAMBDA_ID
	rm -rf $DIRPATH
	cp -r $SRC $DIRPATH

	docker build -t $LAMBDA_ID $DIRPATH
	echo $IMAGE
	DATA='{"image": "'$LAMBDA_ID'", "lambda_id": "'$LAMBDA_ID'"}'
	echo $DATA | node_modules/mustache/bin/mustache - fodocker.yml.mustache > $DIRPATH/fodocker.yml

	# SEND TO FODOCKER
fi
