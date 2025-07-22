#!/bin/bash

set -e

# === Configuration ===

AZURE_PAT=$AZURE_PAT
AZURE_NAME=$AZURE_NAME
AZURE_EMAIL=$AZURE_EMAIL
AZURE_ORG=$AZURE_ORG

# === Derived ===++

rm -rf Automation/.git

git fetch origin
git rebase --root origin/master

git pull --ff-only https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git

git config --global user.name "$AZURE_NAME"
git config --global user.email "$AZURE_EMAIL"



echo "✅ Sync complete"
