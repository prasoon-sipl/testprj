#!/bin/bash

# This script is designed to check the object versioning status of all S3 buckets associated with an AWS account
# and enable object versioning on any S3 buckets where object versioning is not enabled.

# Get list of S3 buckets from Amazon Web Services

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

# Loop through the list of S3 buckets and check the individual bucket's object version status.

for bucket in $(echo "$s3_bucket_list")
do
  version_status=$(aws s3api get-bucket-versioning --bucket "$bucket" | awk '/Status/ {print $2}' | sed 's/"//g')
   if [[ "$version_status" = "Enabled" ]]; then
      
      # If the object version status is Enabled, report that the S3 bucket has object versioning enabled.
      
      echo "The $bucket S3 bucket has object versioning enabled."
  elif [[ "$version_status" != "Enabled" ]]; then
  
      # If the object version is a status other than Enabled, report that the S3 bucket does not have
      # object versioning enabled, then enable object versioning
  
      echo "The $bucket S3 bucket does not have object versioning enabled. Enabling object versioning on the $bucket S3 bucket."
      aws s3api put-bucket-versioning --bucket "$bucket" --versioning-configuration Status=Enabled
  fi
done

#===========================================================================
#!/bin/bash

#for BRANCH in `git branch --list|sed 's/\*//g'`;
#  do 
#    echo "$BRANCH"
#    echo $CIRCLE_BRANCH

							# for bucketlist in `aws s3api list-buckets --query "Buckets[].Name" | sed 's/.systematixinfotech\.*//'`;
							# 	do
							# 	 for bucketname in "${bucketlist[@]}"
							# 		do
							# 			echo "$bucketname"
							# 		done
							# 	done
#  done
#================================================================================

# for folder in `aws s3 ls backups_bucket/ | awk '{print $2}' | cut -d '/' -f 1` ;
# do
#   echo "$folder";
#   aws s3 ls backups_bucket/$folder/2014_10_12/;
# done


# BUCKET=myBucketName
# for dir in $(aws s3 ls $BUCKET | awk '{print $2}'); do
#     aws s3 cp s3://$BUCKET/${dir}myFile.abc s3://$BUCKET/${dir}myNewFolder/myFile.abc
# done