#!/bin/bash

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for bucket in $(echo "$s3_bucket_list")
do
   #echo "$bucket"
   b1 = sed 's/.systematixinfotech.com//g' bucket
   echo "$b1"
done
