#!/bin/bash

set -e

# === Configuration ===

AZURE_PAT=$AZURE_PAT
AZURE_NAME=$AZURE_NAME
AZURE_EMAIL=$AZURE_EMAIL
AZURE_ORG=$AZURE_ORG

# === Derived ===++

rm -rf Automation/.git

#git fetch origin
#git rebase --root origin/master**

# Fetch the changes from Azure DevOps to ensure we have latest
git fetch --unshallow

# Pull changes from Azure DevOps if its exiting branch and have commits on it
git pull https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git

# Set Git user identity
git config --global user.name "$AZURE_NAME"
git config --global user.email "$AZURE_EMAIL"

# Add all changes into stage, commit, and push to Azure DevOps
git add .
git commit -m "Sync from GitHub to Azure DevOps"
git push --force https://$AZUSERNAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git

echo "✅ Sync complete"
