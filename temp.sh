for remote in `git branch -r |grep -v HEAD | sed 's/\*//g'| sed "s/origin\///" `; 
do 
  echo $remote
done
