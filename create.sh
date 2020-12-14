#! /bin/bash

user=$1

if [ $# -ne 1 ]; then
  echo "Error: parameters problem"
  exit 1
fi

if [ -d "$user" ]; then
  echo "Error: The user already exists"
  exit 2
fi

mkdir "$user"
touch "$user"/wall
touch "$user"/friends
echo "OK: user created" 


