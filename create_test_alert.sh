#!/usr/bin/env bash

curl -X POST http://localhost:9093/api/v2/alerts -H "Content-Type: application/json" -d @test_alert.json
curl -s http://localhost:9093/api/v2/alerts | jq '.'
