#!/bin/bash

# REQUIRED ENVIRONMENT VARS
# API_KEY
# TOKEN
# WORK_BOARD_ID
# TEMPLATES_LIST_ID
# TICKET_CARD_TEMPLATE_ID

BASE_URL="https://api.trello.com/1"
CARDS_URL="/cards"
BOARDS_URL="/boards"
TICKET_NO="$1"
TICKET_NAME="$2"
CARD_NAME="MRM-$TICKET_NO-$TICKET_NAME"
AUTH_PARAMS="&key=$API_KEY&token=$TOKEN"

# GET SPRINT BOARD URL
GET_SPRINT_LIST_ID_URL="$BASE_URL$BOARDS_URL/$WORK_BOARD_ID/lists?cards=open&card_fields=id&filter=open&fields=id$AUTH_PARAMS"

LATEST_SPRINT_LIST_ID=$(curl --request GET \
  --url $GET_SPRINT_LIST_ID_URL \
  | jq .[0].id \
  | sed 's/"//g')

echo $LATEST_SPRINT_LIST_ID

# create ticket
CREATE_TICKET_URL="$BASE_URL$CARDS_URL?name=$CARD_NAME&pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$TICKET_CARD_TEMPLATE_ID&keepFromSource=all$AUTH_PARAMS"

curl --request POST \
  --url $CREATE_TICKET_URL

exit 0