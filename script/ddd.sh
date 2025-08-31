# === Derived ===++

rm -rf Automation/.git

echo "1"
# Fetch the changes from Azure DevOps to ensure we have latest
git fetch $GITHUB_URL
echo "2"
# Pull changes from Azure DevOps if its exiting branch and have commits on it


#git pull https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git
echo "3"
# Fetch remote branch
git fetch "$REMOTE_URL" master

# Reset local branch to match remote
#git reset --hard FETCH_HEAD

echo "Repo synced with remote successfully. "

# Set Git user identity
git config --global user.name "$AZURE_NAME"
git config --global user.email "$AZURE_EMAIL"
echo "4"
#git push "$REMOTE_URL" master --force
# Add all changes into stage, commit, and push to Azure DevOps dd
git add .
echo "45"

git commit -m "Sync from GitHub to Azure DevOps"
echo "6"
git push "$REMOTE_URL" master --force
#git push --force https://$AZURE_NAME:$AZURE_PAT@dev.azure.com/$AZURE_ORG/My%20first%20DevOps/_git/Automation.git
echo "7"
#echo "✅ Sync complete"