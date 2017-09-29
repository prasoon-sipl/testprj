#!/bin/bash

bucket_list=()
branch_list=()
branch_list1=()
different_bucket_name=()

#==================================================================
# Deleting the refs to the branches that don't exist on the remote #
#==================================================================
git remote prune origin

#==============================
#  Fetch bucket list from S3  #
#==============================
s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for bucket in $(echo "$s3_bucket_list")
do
  search_string="-staging.gardenuity.com"  
  match=$(echo "$bucket" | grep -- -o $search_string) 
  [[ ! -z $match ]] && bucket_list+=("$bucket")
done

for i in "${bucket_list[@]}"
do
   b=${i//-staging.gardenuity.com/}
   bucket_list1+=("$b")
done

#==============================
#  Fetch Branch list from git #
#==============================

for remote in `git branch -r |grep -v HEAD | sed 's/\*//g'| sed "s/origin\///" `; 
do 
    branch_list+=("$remote") 
done

#=========================================
#  Get bucket name for non exists branch  #
#=========================================

different_bucket_name=(`echo ${bucket_list1[@]} ${branch_list[@]} | tr ' ' '\n' | sort | uniq -u `)


#=====================================
# Delete unmatched bucket by name    #
# if bucket list is not empty .       # 
#=====================================
echo ${branch_list[@]}
echo ${bucket_list1[@]}
echo ${different_bucket_name[@]}

# if [ ${#bucket_list1[@]} -eq 0 ]; then
#     echo "No buckets for deletion."
# else
#     for j in "${different_bucket_name[@]}"
#     do
      
#       bucket1="$j"
#       bucket2="-staging.gardenuity.com"
#       bucket3="$bucket1$bucket2"
#       echo $bucket3
#       #==delete bucket=====================
#       #aws s3 rb s3://$bucket3 --force
#     done
# fi