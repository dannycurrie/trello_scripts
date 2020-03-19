#!/bin/bash
source ./check-env-vars.sh


# REQUIRED ENVIRONMENT VARS
# TRELLO_API_KEY
# TRELLO_TOKEN
# TRELLO_WORK_BOARD_ID
# TEMPLATES_LIST_ID
# CODE_REVIEW_CARD_TEMPLATE_ID

BASE_URL="https://api.trello.com/1"
CARDS_URL="/cards"
BOARDS_URL="/boards"
TICKET_NO="$1"
TICKET_NAME="$2"
CARD_NAME="Code%20Review%20MRM-$TICKET_NO-$TICKET_NAME"
AUTH_PARAMS="&key=$TRELLO_API_KEY&token=$TRELLO_TOKEN"

checkEnvVars

# GET SPRINT BOARD URL
GET_SPRINT_LIST_ID_URL="$BASE_URL$BOARDS_URL/$TRELLO_WORK_BOARD_ID/lists?cards=open&card_fields=id&filter=open&fields=id$AUTH_PARAMS"

LATEST_SPRINT_LIST_ID=$(curl --request GET \
  --url $GET_SPRINT_LIST_ID_URL \
  | jq .[0].id \
  | sed 's/"//g')

echo $LATEST_SPRINT_LIST_ID

# create ticket
CREATE_TICKET_URL="$BASE_URL$CARDS_URL?name=$CARD_NAME&pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$CODE_REVIEW_CARD_TEMPLATE_ID&keepFromSource=all$AUTH_PARAMS"

curl --request POST \
  --url $CREATE_TICKET_URL

exit 0