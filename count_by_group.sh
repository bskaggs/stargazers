#!/bin/bash
jq -c 'select(.payload.action == "started") | {user: .actor.url, item: .repo.name}'  | jq -sc 'group(.item) | map({namespace:.[0].item | split("/")[0], count: map(.user) | unique | length}) | group(.namespace) | map({namespace: .[0].namespace, count: map(.count) | add }) | sort(.count) | .[]'
