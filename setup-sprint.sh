#!/bin/bash
source ./get-latest-sprint-list.sh

# REQUIRED ENVIRONMENT VARS:
# TRELLO_API_KEY
# TRELLO_TOKEN
# WORK_BOARD_ID
# SPRINT_REVIEW_CARD_TEMPLATE_ID
# LEARNING_LOG_CARD_TEMPLATE_ID

BASE_URL="https://api.trello.com/1"
CARDS_URL="/cards"
BOARDS_URL="/boards"
SPRINT_NO="$1"
LIST_NAME="Library%20Sprint%20$SPRINT_NO"
AUTH_PARAMS="&key=$TRELLO_API_KEY&token=$TRELLO_TOKEN"
LEARNING_LOG_CARD_NAME="Learning%20Log%20Sprint%20$SPRINT_NO"
SPRINT_REVIEW_CARD_NAME="Sprint%20Review%20$SPRINT_NO"
LEARNING_GOALS_CARD_NAME="Learning%20Goals%20Sprint%20$SPRINT_NO"

# Create new list
NEW_LIST_URL="$BASE_URL/lists?name=$LIST_NAME&idBoard=$TRELLO_WORK_BOARD_ID&pos=top$AUTH_PARAMS"
# grab the id of the new list from the response
LATEST_SPRINT_LIST_ID=$(curl --request POST \
  --url "$NEW_LIST_URL" \
  | jq .id \
  | sed 's/"//g')

# Add learning log card
CREATE_TICKET_URL="$BASE_URL$CARDS_URL?name=$LEARNING_LOG_CARD_NAME&pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$LEARNING_LOG_CARD_TEMPLATE_ID&keepFromSource=all$AUTH_PARAMS"
curl --request POST \
  --url $CREATE_TICKET_URL

# add sprint review card
CREATE_TICKET_URL="$BASE_URL$CARDS_URL?name=$SPRINT_REVIEW_CARD_NAME&pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$SPRINT_REVIEW_CARD_TEMPLATE_ID&keepFromSource=all$AUTH_PARAMS"
curl --request POST \
  --url $CREATE_TICKET_URL

# add learning goals card
CREATE_TICKET_URL="$BASE_URL$CARDS_URL?name=$LEARNING_GOALS_CARD_NAME&pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$LEARNING_GOALS_CARD_TEMPLATE_ID&keepFromSource=all$AUTH_PARAMS"
curl --request POST \
  --url $CREATE_TICKET_URL

# copy any ticket cards not labelled done

# get previous sprint list
GET_PREV_SPRINT_LIST_ID_URL="$BASE_URL/boards/$TRELLO_WORK_BOARD_ID/lists?cards=open&card_fields=id&filter=open&fields=id$AUTH_PARAMS"
PREV_SPRINT_LIST_ID=$(curl --request GET \
  --url $GET_PREV_SPRINT_LIST_ID_URL \
  | jq .[1].id \
  | sed 's/"//g')

# get ids of incomplete cards from previous sprint
PREV_SPRINT_CARDS_URL="$BASE_URL/lists/${PREV_SPRINT_LIST_ID}/cards?fields=name,labels$AUTH_PARAMS"
INCOMPLETE_TICKET_IDS=$(curl --request GET \
  --url $PREV_SPRINT_CARDS_URL \
  | jq '.[] | select(.name|startswith("MRM-")) | select(.labels[0].name != "Done") | .id' \
  | sed 's/"//g')

# copy cards to new sprint
for CARD_ID in $INCOMPLETE_TICKET_IDS
do
	CREATE_TICKET_URL="$BASE_URL/cards/?pos=top&idList=$LATEST_SPRINT_LIST_ID&idCardSource=$CARD_ID&keepFromSource=all$AUTH_PARAMS"

  curl --request POST \
  --url $CREATE_TICKET_URL
done

exit 0