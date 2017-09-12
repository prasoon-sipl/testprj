#!/bin/bash
for BRANCH in `git branch --list|sed 's/\*//g'`;
  do 
    echo "$BRANCH"
    aws s3 website s3://$Branch/ --index-document index.html --error-document error.html
  done
