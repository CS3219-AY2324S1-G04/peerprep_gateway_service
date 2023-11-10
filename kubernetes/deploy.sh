#!/usr/bin/env bash

config_map_instructions="\n"\
"Before deploying, we require that a config map be applied as the global\n"\
"configuration for the NGINX controller. Refer to the\n"\
"\"./config_maps/nginx_ingress.yaml\" file for more information.\n"\
"\n"\
"You may skip this message in future runs of the deployment script by\n"\
"specifying the \"-y\" argument.\n"\
"\n"

should_skip_config_map_instructions=0

while getopts y flag
do
  case "${flag}" in
    y)
      should_skip_config_map_instructions=1
      ;;
  esac
done

if [[ $should_skip_config_map_instructions == 0 ]]; then
  echo -en $config_map_instructions
  read -p 'Have you applied the config map? (Y/N): ' response
  echo
  if [[ $response != 'Y' && $response != 'y' ]]; then
    echo Deployment aborted.
    exit 1
  fi
fi

kubectl apply -f ./ingress/gateway.yaml
