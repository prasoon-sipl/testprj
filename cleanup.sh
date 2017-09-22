#!/bin/bash
bucket_list=()
bucket_list1=()
branch_list=()
different_bucket_name=()

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')
#-e 's/.systematixinfotech.com//g'
for bucket in $(echo "$s3_bucket_list")
do
   bucket_list+=("$bucket")
  
done
#==========================
search_string=".systematixinfotech.com"  
match=$(echo "${bucket_list[@]:0}" | grep -o $search_string)  
[[ ! -z $match ]] && bucket_list1+=("$bucket")
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
echo ${bucket_list1[@]} 
exit
#echo ${branch_list[@]} 

different_bucket_name=(`echo ${bucket_list[@]} ${branch_list[@]} | tr ' ' '\n' | sort | uniq -u `)
echo ${different_bucket_name[@]} 
exit