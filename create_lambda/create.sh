#!/bin/bash

SRC=$1
FODOCKER_NET=lambdabase_default
#FODOCKER_NET=fodocker_default
LAMBDA_ID=lambda_$(cat $(find $SRC -type f) | md5)

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
	docker run -v $DIRPATH/fodocker.yml:/tmp/fodocker.yml:ro --net=$FODOCKER_NET byrnedo/alpine-curl -F "file=@/tmp/fodocker.yml" http://watcher:3000/
fi
