#!/bin/bash

#for BRANCH in `git branch --list|sed 's/\*//g'`;
#  do 
#    echo "$BRANCH"
#    echo $CIRCLE_BRANCH

for bucketlist in `aws s3api list-buckets --query "Buckets[].Name"`;
	do
	 for bucketname in "${bucketlist[@]}"
		do
			echo "$bucketname"
		done
	done
#  done
