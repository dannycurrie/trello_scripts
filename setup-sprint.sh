#!/bin/bash

# REQUIRED ENVIRONMENT VARS:
# API_KEY
# TOKEN
# WORK_BOARD_ID
# SPRINT_REVIEW_CARD_TEMPLATE_ID
# LEARNING_LOG_CARD_TEMPLATE_ID

BASE_URL="https://api.trello.com/1"
CARDS_URL="/cards"
BOARDS_URL="/boards"
SPRINT_NO="$1"
AUTH_PARAMS="&key=$API_KEY&token=$TOKEN"

# Create new list
# Add learning log card
# add sprint review card
# add learning goals card
# copy any ticket cards not labelled done

exit 0