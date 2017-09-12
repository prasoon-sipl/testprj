#!/bin/bash
for BRANCH in `git branch --list|sed 's/\*//g'`;
  do 
    echo "$BRANCH"
  done
