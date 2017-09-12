#!/bin/bash

for BRANCH in `git branch --list|sed 's/\*//g'`;
  do 
    echo "$BRANCH"
    aws s3 mb s3://$BRANCH.systematixinfotech.com
    aws s3 website s3://$BRANCH.systematixinfotech.com/ --index-document index.html --error-document error.html
    aws s3 sync /home/ubuntu/testprj s3://$BRANCH.systematixinfotech.com --delete
  done
