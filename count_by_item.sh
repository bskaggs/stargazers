#!/bin/bash
jq -c 'select(.payload.action == "started") | {user: .actor.url, item: .repo.name}'  | jq -sc 'group(.item) | map({item:.[0].item, count: map(.user) | unique | length}) | sort(.count) |  .[]'
