#!/bin/bash
bucket_list=()
branch_list=()
branch_list1=()
different_bucket_name=()

s3_bucket_list=$(aws s3api list-buckets --query 'Buckets[*].Name' | sed -e 's/[][]//g' -e 's/"//g' -e 's/,//g' -e '/^$/d' -e 's/^[ \t]*//;s/[ \t]*$//')
#-e 's/.systematixinfotech.com//g'
for bucket in $(echo "$s3_bucket_list")
do
   #bucket_list+=("$bucket")
  search_string=".systematixinfotech.com"  
  match=$(echo "$bucket" | grep -o $search_string)  
  [[ ! -z $match ]] && bucket_list+=("$bucket")
done
#=======================================================

for i in "${bucket_list[@]}"
do
   #b =$(sed -e 's/.systematixinfotech.com//g' "$i")
   #b =$("$i" | sed -r 's/[.systematixinfotech.com]+//g')
   #b=echo "$i" | tr '[.systematixinfotech.com]' ''
   #${i//[.systematixinfotech.com]/}
   b=${i//.systematixinfotech.com/}
   bucket_list1+=("$b")
done

#============================================

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