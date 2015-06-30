#!/bin/bash
jq -c 'select(.payload.action == "started") | {user: .actor.url, item: .repo.name}'  | jq -cs 'group(.user) | map({user:.[0].user, items: map(.item) | unique}) | .[]' 
