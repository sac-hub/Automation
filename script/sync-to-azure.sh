#!/usr/bin/env bash
set -e

# === Configuration =======================================================================================

AZURE_PAT=$AZURE_PAT
AZURE_NAME=$AZURE_NAME
AZURE_EMAIL=$AZURE_EMAIL
AZURE_ORG=$AZURE_ORG

# Source of truth = GitHub
GITHUB_URL="https://github.com/sac-hub/Automation.git"

# Target = Azure DevOps
REMOTE_URL="https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git"

# === Sync Process ========================================================================================

echo "1. Resetting remotes... "
git remote remove origin || true
git remote add origin "$GITHUB_URL"

git remote remove azure || true
git remote add azure "$REMOTE_URL"

echo "2. Fetching from GitHub..."
git fetch origin master

echo "3. Resetting local master to GitHub state..."
git checkout master || git checkout -b master
git reset --hard origin/master

echo "4. Setting Git identity (local to repo)..."
git config user.name "$AZURE_NAME"
git config user.email "$AZURE_EMAIL"

echo "5. Force pushing to Azure DevOps..."
git push azure master --force

echo "✅ Sync from GitHub → Azure DevOps completed successfully."
