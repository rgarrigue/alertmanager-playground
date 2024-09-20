#!/usr/bin/env bash

curl -X POST http://localhost:9093/api/v2/silences \
-H "Content-Type: application/json" \
-d '{
    "matchers": [
        {
            "name": "alertname",
            "value": "Test alert",
            "isRegex": false
        }
    ],
    "startsAt": "2024-01-01T00:00:00Z",
    "endsAt": "2034-01-01T00:00:00Z",
    "createdBy": "Tester",
    "comment": "Silence test alert."
}'
