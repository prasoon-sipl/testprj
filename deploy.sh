#!/bin/bash

for i in $(git branch -r)
do
 echo $i
done
