#! /bin/bash

user=$1
friend=$2

if [ $# -ne 2 ]; then
  echo "Error: parameters problem"
  exit 1
fi

if ! [ -d "$user" ]; then
  echo "Error: user does not exist"
  exit 2
fi

if ! [ -d "$friend" ]; then
  echo "Error: friend does not exist"
  exit 2
fi

./P.sh "$user"/friends

if ! [ -z `grep "$friend" "$user"/friends` ]; then
  echo "Error: user already friends with this user"
  ./V.sh "$user"/friends
  exit 3
fi

echo "$friend" >> "$user"/friends
./V.sh "$user"/friends
echo "OK: friend added"

