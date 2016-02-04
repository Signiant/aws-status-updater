# aws-status-updater
Updates an icon depending on whether there are outages on the AWS status page

This consists of 2 scripts:

* A python script (written by Ryan Hartkopf) which checks the AWS status page for outages
* A shell script which checks the result of this and uploads either a green or red icon to an S3 bucket

The shell script is intended to be run from cron on a fairly tight frequency (ie. 1 minute)

We use this to integrate with an on-call system. The idea is that in the on-call system, we have a link to the image file in the S3 bucket.  When we are called, the icon displays red or green depending on whether AWS has any outages at the time.
