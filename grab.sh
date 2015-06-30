#!/bin/bash

d=2014-12-22
while [ "$d" != 2014-12-31 ]; do 
  d=$(date -I -d "$d + 1 day")
  echo $d
  curl http://data.githubarchive.org/$d-{0..23}.json.gz | zcat | jq 'select(.type == "WatchEvent")' | gzip > $d.jsonl.gz
done
