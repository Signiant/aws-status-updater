#!/bin/bash

OK_IMAGE=tick-circle-frame.png
ERROR_IMAGE=exclamation-red-frame.png

S3_DESTINATION=$1

DEST_BUCKET=my-bucket
BUCKET_IMAGE_NAME=service-status/current-aws-status.png

if [ $# -ne 1 ]; then
  echo "You must provide an S3 destination name for the status image (ie. s3://mybucket/service-status/current-aws-status.png)"
  exit 1
fi

if [ -z "${S3_DESTINATION}" ]; then
  echo "You must provide an S3 destination name for the status image (ie. s3://mybucket/service-status/current-aws-status.png)"
  exit 1
else
  echo "Status image will be uploaded to ${S3_DESTINATION}"
fi

./check_aws_status_feed.py all
STATUS=$?

if [ $STATUS -eq 0 ]; then
	echo "Looks like AWS is all good..."
	IMAGE_TO_UPLOAD=${OK_IMAGE}
else
	echo "Looks like AWS has a problem..."
	IMAGE_TO_UPLOAD=${ERROR_IMAGE}
fi

aws s3 cp ${IMAGE_TO_UPLOAD} ${S3_DESTINATION} --acl public-read
