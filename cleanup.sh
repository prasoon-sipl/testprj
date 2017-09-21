#!/bin/bash

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e 's/.systematixinfotech.com//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')
bucket_list=()
for bucket in $(echo "$s3_bucket_list")
do
   bucket_list += "$bucket"
done

echo "${bucket_list[*]}"