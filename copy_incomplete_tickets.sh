
#!/bin/bash

BASE_URL="https://api.trello.com/1"
AUTH_PARAMS="&key=$TRELLO_API_KEY&token=$TRELLO_TOKEN"

# get all cards in previous sprint list
GET_SPRINT_LIST_ID_URL="$BASE_URL/boards/$TRELLO_WORK_BOARD_ID/lists?cards=open&card_fields=id&filter=open&fields=id$AUTH_PARAMS"
LATEST_SPRINT_LIST_ID=$(curl --request GET \
  --url $GET_SPRINT_LIST_ID_URL \
  | jq .[0].id \
  | sed 's/"//g')

LATEST_SPRINT_CARDS_URL="$BASE_URL/lists/${LATEST_SPRINT_LIST_ID}/cards?fields=name,labels$AUTH_PARAMS"
LATEST_SPRINT_CARDS=$(curl --request GET \
  --url $LATEST_SPRINT_CARDS_URL)

# for each card
# if name starts with MRM && labels doesn't include 'done'
# copy it to the new sprint list