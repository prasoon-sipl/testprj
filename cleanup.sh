#!/bin/bash

for BRANCH in `git branch --list`;
  do 
    echo "$BRANCH"
    echo $CIRCLE_BRANCH

#for bucketlist in `aws s3api list-buckets --query "Buckets[].Name" | sed 's/.systematixinfotech\.*//'`;
#	do
#	 for bucketname in "${bucketlist[@]}"
#		do
#			echo "$bucketname"
#		done
#	done
  done
