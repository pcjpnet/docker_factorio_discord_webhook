#!/bin/bash
set -eoux pipefail

tail -F /opt/factorio/factorio-current.log |
while read m_time m_type m_module m_msg; do

m_module=`echo $m_module | cut -d: -f1`;
m_mode=`echo $m_msg | cut -d' ' -f2`;
if [[ $m_module == 'ServerSynchronizer.cpp' ]]; then
  if [[ $m_mode == 'adding' ]]; then
  curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"content":"'"$TEXT_LOGIN"'"}' "$WEBHOOK";
  elif [[ $m_mode == 'removing' ]]; then
  curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"content":"'"$TEXT_LOGOUT"'"}' "$WEBHOOK";
  fi
fi

done
