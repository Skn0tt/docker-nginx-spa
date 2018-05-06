#!/bin/bash

if [[ $CONFIG_VARS ]]; then

  SPLIT=$(echo $CONFIG_VARS | tr "," "\n")
  ARGS=
  for VAR in ${SPLIT}; do
      ARGS="${ARGS} -v ${VAR} "
  done

  JSON=`json_env --json $ARGS`

  echo " ==> Sending ${CONFIG_COOKIE} cookie with ${JSON}"
  
fi

export DOLLAR='$'
export CONFIG_COOKIE_CONTENT=${JSON-"{}"}

envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf

exec "$@"
