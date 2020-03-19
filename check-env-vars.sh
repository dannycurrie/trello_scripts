#!/bin/bash

function checkEnvVars {
  if [ -z "$TRELLO_API_KEY"  ] || [ -z "$TRELLO_TOKEN" ] ; then
    echo "Trello api key and/or token are empty! Did you forget to source .bash_profile?"
    exit 1
  fi
}
