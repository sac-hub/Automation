#!/usr/bin/env bash
set -e

# Required Bats version
REQUIRED_BATS_VERSION="1.8.2"

# Temporary install directory
BATS_TMP="/tmp/bats-core"

# Check if bats is installed
if ! command -v bats &> /dev/null; then
  echo "Bats not found. Installing Bats..."
  rm -rf "$BATS_TMP"
  git clone https://github.com/bats-core/bats-core.git "$BATS_TMP"
  sudo "$BATS_TMP/install.sh" /usr/local
fi

# Get installed Bats version
INSTALLED_BATS_VERSION=$(bats --version | awk '{print $2}')

# Compare versions
if [ "$INSTALLED_BATS_VERSION" != "$REQUIRED_BATS_VERSION" ]; then
  echo "Installed Bats version ($INSTALLED_BATS_VERSION) does not match required version ($REQUIRED_BATS_VERSION). Reinstalling..."
  rm -rf "$BATS_TMP"
  git clone https://github.com/bats-core/bats-core.git "$BATS_TMP"
  cd "$BATS_TMP"
  sudo ./install.sh /usr/local
fi

# Confirm installation
echo "Bats version $(bats --version) installed successfully."


# Confirm installation
echo "Bats version $(bats --version) installed successfully."

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
git fetch #--unshallow

# Pull changes from Azure DevOps if its exiting branch and have commits on it
git pull https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git

# Set Git user identity
git config --global user.name "$AZURE_NAME"
git config --global user.email "$AZURE_EMAIL"

# Add all changes into stage, commit, and push to Azure DevOps dd
git add .
git commit -m "Sync from GitHub to Azure DevOps"
git push --force https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git

echo "✅ Sync complete"
