#!/bin/bash

IMAGE=blablablaimg
LAMBDA_ID=1234567890



echo "{\"image\": \"$IMAGE\", \"lambda_id\": \"$LAMBDA_ID\"}" | node_modules/mustache/bin/mustache - fodocker.yml.mustache
