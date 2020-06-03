#!/bin/bash
set -eu

REGION_SEPARATOR='::'

ec2_instance_id="$1"
ssh_user="$2"
ssh_port="$3"
ssh_public_key_path="$4"

if [[ "${ec2_instance_id}" = *${REGION_SEPARATOR}* ]]
then
  export AWS_REGION="${ec2_instance_id##*${REGION_SEPARATOR}}"
  ec2_instance_id="${ec2_instance_id%%${REGION_SEPARATOR}*}"
fi

echo "Add public key ${ssh_public_key_path} to instance ${ec2_instance_id} for 60 seconds" >/dev/tty
aws ssm send-command \
  --instance-ids "${ec2_instance_id}" \
  --document-name 'AWS-RunShellScript' \
  --comment "Add an SSH public key to authorized_keys for 60 seconds" \
  --parameters commands="\"
    cd ~${ssh_user}/.ssh || exit 1
    public_key='$(cat "${ssh_public_key_path}") ssm-session'
    echo \\\"\${public_key}\\\" >> authorized_keys
    sleep 60
    grep -v -F \\\"\${public_key}\\\" authorized_keys > .authorized_keys
    mv .authorized_keys authorized_keys
  \""

echo "Start ssm session to instance ${ec2_instance_id}" >/dev/tty
aws ssm start-session \
  --target "${ec2_instance_id}" \
  --document-name 'AWS-StartSSHSession' \
  --parameters "portNumber=${ssh_port}"
