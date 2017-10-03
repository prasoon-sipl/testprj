#!/bin/bash

function JSONizePolicy() {
	echo '{"Version": "2012-10-17","Statement": [{"Action": ["s3:GetObject","s3:PutObject"],"Effect": "Allow","Resource": ["arn:aws:s3:::'"$1"'/*"]}]}'> policy.json
}

if [ $CIRCLE_BRANCH = 'master' ]; 
		then aws s3 sync D:/circle_ci/testprj s3://master.systematixinfotech.com --delete;
	         
	else
   

        aws s3 mb s3://$CIRCLE_BRANCH.systematixinfotech.com
        # Set bucket policy
	    JSONizePolicy $CIRCLE_BRANCH.systematixinfotech.com

	    aws s3api put-bucket-policy --bucket $CIRCLE_BRANCH.systematixinfotech.com --policy file://policy.json 2>&1
        aws s3 website s3://$CIRCLE_BRANCH.systematixinfotech.com/ --index-document index.html --error-document error.html
        aws s3 sync D:/circle_ci/testprj s3://$CIRCLE_BRANCH.systematixinfotech.com --delete
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
	    
# 	    aws s3 mb s3://$CIRCLE_BRANCH-staging.gardenuity.com
# 	    # Set bucket policy
# 	    JSONizePolicy $CIRCLE_BRANCH-staging.gardenuity.com
# 	    aws s3api put-bucket-policy --bucket $CIRCLE_BRANCH-staging.gardenuity.com --policy file://policy.json 2>&1
#         aws s3 website s3://$CIRCLE_BRANCH-staging.gardenuity.com/ --index-document index.html --error-document error.html
#         aws s3 sync _site/ s3://$CIRCLE_BRANCH-staging.gardenuity.com --delete
# fi
