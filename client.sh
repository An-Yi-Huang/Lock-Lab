#! /bin/bash

if [ $# -lt 2 ]; then
  echo "Error: parameters problem"
  exit 1
fi

open_pipe() {
  mkfifo $1.pipe
}

send_msg() {
  echo "$@" > server.pipe  
}

receive_msg() {
  while read input; do
    echo "$input"
  done < $1.pipe
}

close_pipe() {
  rm -f $1.pipe
  if [[ -z $? ]]; then
    exit 0
  fi 
  exit $?
}

normal_request_process() {
      open_pipe "$@"
      send_msg "$@"
      receive_msg "$@"
      close_pipe "$@"
}

case "$2" in
  create)
    if [[ $# == 3 ]]; then
      normal_request_process "$@"
    fi
    ;;
  add)
  if [[ $# == 4 ]]; then
      normal_request_process "$@"
  fi
  ;;
  post)
  if [[ $# == 5 ]]; then
      normal_request_process "$@"
  fi
  ;;
  show)
  if [[ $# == 3 ]]; then
      normal_request_process "$@"
  fi
  ;;
esac

rm -f $1.pipe
echo "Error: bad request"
exit 1
