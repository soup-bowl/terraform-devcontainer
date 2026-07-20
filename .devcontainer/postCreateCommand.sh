#!/usr/bin/env bash

pre-commit install

# Azure
az extension add --name bastion
az extension add --name ssh

# AWS
aws configure set region eu-west-2
