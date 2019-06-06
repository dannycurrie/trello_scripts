#!/bin/bash

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

# Create new list
NEW_LIST_URL="$BASE_URL/lists?name=$LIST_NAME&idBoard=$TRELLO_WORK_BOARD_ID&pos=top$AUTH_PARAMS"
curl --request POST \
  --url "$NEW_LIST_URL"
# Add learning log card
# add sprint review card
# add learning goals card
# copy any ticket cards not labelled done

exit 0