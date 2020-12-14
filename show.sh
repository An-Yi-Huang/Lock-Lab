#! /bin/bash

user=$1

if [ $# -ne 1 ]; then
  echo "Error: parameters problem" 
  exit 1
fi

if ! [ -d $user ]; then
  echo "Error: user does not exist"
  exit 2
fi

echo "wallStart"
cat $user/wall
echo "wallEnd"
