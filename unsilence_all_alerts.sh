#!/usr/bin/env bash

IDS=$(curl -s http://localhost:9093/api/v2/silences | jq -r '.[].id')

for silence in $IDS
do
    curl -s -X DELETE http://localhost:9093/api/v2/silence/$silence | jq '.'
done