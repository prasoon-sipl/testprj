#!/bin/bash

#for BRANCH in `git branch --list|sed 's/\*//g'`;
#  do 
#    echo "$BRANCH"
#    echo $CIRCLE_BRANCH

for names in `aws s3api list-buckets --query "Buckets[].Name"`;
	do
	 echo $names;
	done
#  done
