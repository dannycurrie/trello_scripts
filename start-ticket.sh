#!/bin/bash
source ./get-latest-sprint-list.sh
source ./check-env-vars.sh

# REQUIRED ENVIRONMENT VARS
# TRELLO_API_KEY
# TRELLO_TOKEN
# TRELLO_WORK_BOARD_ID
# TEMPLATES_LIST_ID
# TICKET_CARD_TEMPLATE_ID

BASE_URL="https://api.trello.com/1"
CARDS_URL="/cards"
BOARDS_URL="/boards"
TICKET_NO="$1"
TICKET_NAME="$2"
CARD_NAME="MRM-$TICKET_NO-$TICKET_NAME"
AUTH_PARAMS="&key=$TRELLO_API_KEY&token=$TRELLO_TOKEN"

checkEnvVars

# GET SPRINT BOARD URL
LATEST_SPRINT_LIST_ID=$(getSprintListId)

# create ticket
CREATE_TICKET_URL="$BASE_URL$CARDS_URL?name=$CARD_NAME&pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$TICKET_CARD_TEMPLATE_ID&keepFromSource=all$AUTH_PARAMS"

curl --request POST \
  --url $CREATE_TICKET_URL

exit 0