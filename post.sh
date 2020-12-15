#! /bin/bash

receiver="$1"
sender="$2"
message="$3"

if [ $# -ne 3 ]; then
  echo "Error: parameters problem"
  exit 1
fi

if ! [ -d "$receiver" ]; then
  echo "Error: Receiver does not exist"
  exit 2
fi

if ! [ -d "$sender" ]; then
  echo "Error: Sender does not exist"
  exit 2
fi

if grep -q "$sender" "$receiver/friends" ; then
  echo "$sender": "$message" >> "$receiver"/wall
  echo "Ok: Message posted to wall"
  exit 0
else
  echo "Error: Sender is not a friend of receiver"
  exit 3
fi
