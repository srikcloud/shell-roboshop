#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0e17314d1745c9dac"
INSTANCES=("mongodb" "mysql" "redis" "rabbitmq" "catalogue" "user" "cart" "shipping" 
"payment" "dispatch" "frontend")
ZONE_ID="Z09795462K7LFC60CJ3VQ"
DOMAIN_NAME="srikanth553.store"

for instance in ${INSTANCES[@]}
do
     INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.
     micro  --security-group-ids sg-0e17314d1745c9dac --tag-specifications "ResourceType=instance, 
     Tags=[{Key=Name,Value=$instance}]" --query "Instances[0].PrivateIpAddress" --output text)

if [ $instance != "frontend" ]
then

    IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].
    Instances[0].PrivateIpAddress" --output text)
    
else
    IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].
    Instances[0].PublicIpAddress" --output text)
fi
echo "$instance IP Address: $IP"

done
