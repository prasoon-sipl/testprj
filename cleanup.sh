#!/bin/bash
bucket_list=()
s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e 's/.systematixinfotech.com//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for bucket in $(echo "$s3_bucket_list")
do
   bucket_list+=("$bucket")
  
done

echo ${bucket_list[@]}   


branch_list=()
git branch | grep ^feature/ | while read branch; 
do 
	branch_list+=("$branch")
	#echo $branch; 
done

echo ${branch_list[@]} 
exit