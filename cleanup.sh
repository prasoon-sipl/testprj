#!/bin/bash
bucket_list=()
branch_list=()
branch_list1=()
different_bucket_name=()

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')

for bucket in $(echo "$s3_bucket_list")
do
  search_string=".systematixinfotech.com"  
  match=$(echo "$bucket" | grep -o $search_string)  
  [[ ! -z $match ]] && bucket_list+=("$bucket")
done

for i in "${bucket_list[@]}"
do
   b=${i//.systematixinfotech.com/}
   bucket_list1+=("$b")
done
#kd;lkfdl;kdlkf
#============================================

for remote in `git branch -r | grep -v /HEAD sed -e 's/origin///g'`; 
do 
    #echo $remote ;
    branch_list+=("$remote") 
done

# for branch_name in `git branch -r|sed 's/\*//g'`;
#  do 
#    branch_list+=("$branch_name")
#  done
#========================================================
#echo ${bucket_list1[@]} 
echo ${branch_list[@]} 
exit
different_bucket_name=(`echo ${bucket_list1[@]} ${branch_list[@]} | tr ' ' '\n' | sort | uniq -u `)
echo ${different_bucket_name[@]} 
exit