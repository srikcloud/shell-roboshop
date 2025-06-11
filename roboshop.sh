#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-099eb67ba2a5b54e1" # replace with your SG ID
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z09795462K7LFC60CJ3VQ" # replace with your ZONE ID
DOMAIN_NAME="srikanth553.store" # replace with your domain

for instance in ${INSTANCES[@]}
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-099eb67ba2a5b54e1 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance != "frontend" ]
    then
        IP=aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text
        echo "$instance IP address: $IP"
    else
        IP=aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text
            fi
    echo "$instance IP address: $IP"
done