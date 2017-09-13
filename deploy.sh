#!/bin/bash

#for BRANCH in `git branch --list|sed 's/\*//g'`;
#  do 
#    echo "$BRANCH"
#    echo $CIRCLE_BRANCH
    while read OLDSHA NEWSHA REF ; do
    if [ "$NEWSHA" = "0000000000000000000000000000000000000000" ]; then
    echo "# This ref has been deleted! Respond appropriately."
    fi
    aws s3 mb s3://$CIRCLE_BRANCH.systematixinfotech.com
    aws s3 website s3://$CIRCLE_BRANCH.systematixinfotech.com/ --index-document index.html --error-document error.html
    aws s3 sync /home/ubuntu/testprj s3://$CIRCLE_BRANCH.systematixinfotech.com --delete
#  done
