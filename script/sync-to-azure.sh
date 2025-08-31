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
GITHUB_URL="https://github.com/sac-hub/Automation.git"
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