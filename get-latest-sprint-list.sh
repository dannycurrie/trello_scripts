#!/bin/bash


function getSprintListId {
  BASE_URL="https://api.trello.com/1"
  AUTH_PARAMS="&key=$TRELLO_API_KEY&token=$TRELLO_TOKEN"
  GET_SPRINT_LIST_ID_URL="$BASE_URL/boards/$TRELLO_WORK_BOARD_ID/lists?cards=open&card_fields=id&filter=open&fields=id$AUTH_PARAMS"

  LATEST_SPRINT_LIST_ID=$(curl --request GET \
    --url $GET_SPRINT_LIST_ID_URL \
    | jq .[0].id \
    | sed 's/"//g')

  echo $LATEST_SPRINT_LIST_ID
}