#!/usr/bin/env bash

pre-commit install

# Clone companion repositories if not already present (no-op in Codespaces where they are cloned automatically)
repos=(
	"soup-bowl/servers"
	"soup-bowl/tf-practice"
)

for repo in "${repos[@]}"; do
	name="${repo#*/}"
	if [ ! -d "/workspaces/${name}" ]; then
		gh repo clone "${repo}" "/workspaces/${name}" || git clone "https://github.com/${repo}.git" "/workspaces/${name}"
	fi
done

# Azure

az extension add --name bastion
az extension add --name ssh

# AWS
aws configure set region eu-west-2
