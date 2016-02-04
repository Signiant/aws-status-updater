#!/bin/bash

# Install this script, the python script and the 2 icons in this folder
cd /usr/local/aws-status-updater

OK_IMAGE=tick-circle-frame.png
ERROR_IMAGE=exclamation-red-frame.png

DEST_BUCKET=my-bucket
BUCKET_IMAGE_NAME=service-status/current-aws-status.png

./check_aws_status_feed.py all
STATUS=$?

if [ $STATUS -eq 0 ]; then
	echo "Looks like AWS is all good..."
	# upload the good image
	aws s3 cp ${OK_IMAGE} s3://${DEST_BUCKET}/${BUCKET_IMAGE_NAME} --acl public-read
else
	echo "Looks like AWS has a problem..."
	# upload the error image
	aws s3 cp ${ERROR_IMAGE} s3://${DEST_BUCKET}/${BUCKET_IMAGE_NAME} --acl public-read
fi
