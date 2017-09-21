#!/bin/bash
bucket_list=()
branch_list=()
different_bucket_name=()

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e 's/.systematixinfotech.com//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for bucket in $(echo "$s3_bucket_list")
do
   bucket_list+=("$bucket")
  
done
#=====================================================

		# branchs=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

		# for branch_name in $(echo "$branchs") 
		# do 
		# 	branch_list+=("$branch_name")
		# 	#echo $branch; 
		# done
for branch_name in `git branch --list|sed 's/\*//g'`;
 do 
   branch_list+=("$branch_name")
 done
#========================================================

#echo ${bucket_list[@]} 
#echo ${branch_list[@]} 

different_bucket_name=(`echo ${bucket_list[@]} ${branch_list[@]} | tr ' ' '\n' | sort | uniq -u `)
echo ${different_bucket_name[@]} 
exit