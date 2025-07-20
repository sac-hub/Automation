#!/bin/bash

set -e

# === Configuration ===

AZURE_PAT=$AZURE_PAT
AZURE_NAME=$AZURE_NAME
AZURE_EMAIL=$AZURE_EMAIL
AZURE_ORG = $AZURE_ORG

# === Derived ===+

rm -rf Automation/.git

git fetch

git pull https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My first DevOps/_git/Automation.git

git config --global user.name "$AZURE_NAME"
git config --global user.email "$AZURE_EMAIL"



echo "✅ Sync complete"
