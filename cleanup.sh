#!/bin/bash
bucket_list=()
branch_list=()

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e 's/.systematixinfotech.com//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for bucket in $(echo "$s3_bucket_list")
do
   bucket_list+=("$bucket")
  
done
#=====================================================


branchs=$(git branch | sed -ne 's/^\* \(.*\/\1/p')
for branch_name in $(echo "$branchs") 
do 
	branch_list+=("$branch_name")
	#echo $branch; 
done
#========================================================

echo ${bucket_list[@]} 

echo ${branch_list[@]} 

exit