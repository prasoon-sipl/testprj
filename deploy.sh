#!/bin/bash
  

function JSONizePolicy() {
	echo '{"Version":"2012-10-17","Id":"'"$1"'","Statement":[{"Sid":"PublicReadWriteForBucketObjects","Effect":"Allow","Principal":"*","Action":["s3:GetObject","s3:PutObject"],"Resource":"arn:aws:s3:::'"$1"'/*"}]}' > policy.json
}

if [ $CIRCLE_BRANCH = 'master' ]; 
		then aws s3 sync /home/ubuntu/testprj s3://master-stagingdev.gardenuity.com --delete;
	        
	else
	    
	    aws s3 mb s3://$CIRCLE_BRANCH-stagingdev.gardenuity.com
	    # Set bucket policy
	    JSONizePolicy $CIRCLE_BRANCH-stagingdev.gardenuity.com

	    aws s3api put-bucket-policy --bucket $CIRCLE_BRANCH-stagingdev.gardenuity.com --policy file://policy.json 2>&1
       
        aws s3 website s3://$CIRCLE_BRANCH-stagingdev.gardenuity.com/ --index-document index.html --error-document error.html
       
        aws s3 sync /home/ubuntu/testprj s3://$CIRCLE_BRANCH-stagingdev.gardenuity.com --delete
fi




# function JSONizePolicy() {
# 	echo '{"Version": "2012-10-17","Statement": [{"Action": ["s3:GetObject","s3:PutObject"],"Effect": "Allow","Resource": ["arn:aws:s3:::'"$s3bucketname"'/*"]}]}'> policy.json
# }

# if [ $CIRCLE_BRANCH = 'master' ]; 
# 		then aws s3 sync _site/ s3://gardenuity.com/ --delete;
# 	         # Set bucket policy
# 	         #JSONizePolicy gardenuity.com
# 	         #aws s3api put-bucket-policy --bucket gardenuity.com --policy file://policy.json 2>&1
# 	else
	    
# 	    aws s3 mb s3://$CIRCLE_BRANCH-stagingdev.gardenuity.com
# 	    # Set bucket policy
# 	    JSONizePolicy $CIRCLE_BRANCH-stagingdev.gardenuity.com
# 	    aws s3api put-bucket-policy --bucket $CIRCLE_BRANCH-stagingdev.gardenuity.com --policy file://policy.json 2>&1
#         aws s3 website s3://$CIRCLE_BRANCH-stagingdev.gardenuity.com/ --index-document index.html --error-document error.html
#         aws s3 sync _site/ s3://$CIRCLE_BRANCH-stagingdev.gardenuity.com --delete
# fi