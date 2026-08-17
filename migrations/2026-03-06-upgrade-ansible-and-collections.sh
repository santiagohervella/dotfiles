#!/bin/bash

set -e

pip3 install --upgrade ansible
ansible-galaxy collection install -r requirements.yml -U
