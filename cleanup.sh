#!/bin/bash

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for fullbucket in $(echo "$s3_bucket_list")
do
   bucket = "$fullbucket" | sed 's/.systematixinfotech\.*//'
   echo bucket
done
