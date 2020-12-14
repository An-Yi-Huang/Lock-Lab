#! /bin/bash

mkfifo server.pipe

while true; do
  read request < server.pipe
  rqSplit=($request)
  clientId="${rqSplit[0]}"

  if [[ -z "$request" ]]; then
    continue
  fi

  case "${rqSplit[1]}" in
    create)
      ./create.sh ${rqSplit[2]} > ${rqSplit[0]}.pipe &
      ;;
    add)
      ./add.sh ${rqSplit[2]} ${rqSplit[3]} > ${rqSplit[0]}.pipe &
      ;;
    post)
      msg="${rqSplit[4]}"
      for (( i=5; i <= "${#rqSplit[@]}"; i++ )); do
        msg+=" ${rqSplit[${i}]}"
      done
      ./post.sh ${rqSplit[2]} ${rqSplit[3]}  "${msg}" > ${rqSplit[0]}.pipe &
      ;;
    show)
      ./show.sh ${rqSplit[2]} >  ${rqSplit[0]}.pipe &
      ;;
    shutdown)
      rm -f server.pipe
      exit 0
      ;;
    *)
      rm -f server.pipe
      echo "Error: bad request"
      exit 1
  esac

done
