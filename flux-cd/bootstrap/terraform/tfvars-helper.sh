#!/usr/bin/env bash

set -eu -o pipefail

TFVARS_FILE="project.tfvars"

read -p 'GitHub owner: ' GITHUB_OWNER
read -p 'GitHub personal token: ' GITHUB_TOKEN
read -p 'GitHub repository name: ' GITHUB_REPO_NAME
read -p 'GitHub repository name: ' GITHUB_REPO_NAME

echo "github_owner = \"$GITHUB_OWNER\"" > "$TFVARS_FILE"
echo "github_token = \"$GITHUB_TOKEN\"" >> "$TFVARS_FILE"
echo "repository_name = \"$GITHUB_REPO_NAME\"" >> "$TFVARS_FILE"