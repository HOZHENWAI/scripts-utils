#!/bin/bash

clone_all() {
  gh repo list $USERNAME --json nameWithOwner --limit 5000 | jq -r '.[].nameWithOwner' | xargs -I{} gh repo clone {}
}

clone_all