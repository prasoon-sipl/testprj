#!/bin/bash

    if [ $CIRCLE_BRANCH = 'master' ]; 
		then aws s3 sync /home/ubuntu/testprj s3://master.systematixinfotech.com --delete;
	else
	    aws s3 mb s3://$CIRCLE_BRANCH.systematixinfotech.com
        aws s3 website s3://$CIRCLE_BRANCH.systematixinfotech.com/ --index-document index.html --error-document error.html
        aws s3 sync /home/ubuntu/testprj s3://$CIRCLE_BRANCH.systematixinfotech.com --delete
    fi
   
