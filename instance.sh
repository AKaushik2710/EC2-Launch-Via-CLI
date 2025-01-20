#!/bin/bash
vpc=`aws ec2 create-vpc --cidr-block "10.0.0.0/16" | grep -i "vpcid" | cut -d ":" -f 2 | cut -d '"' -f 2 `
subnet=`aws ec2 create-subnet --vpc-id $vpc --cidr-block "10.0.0.0/24" --availability-zone "ap-south-1a" | grep -i "subnetid" | cut -d ":" -f 2 | cut -d '"' -f 2 `
igw=`aws ec2 create-internet-gateway | grep -i "InternetGatewayId" | cut -d ":" -f 2 | cut -d '"' -f 2 `
`aws ec2 attach-internet-gateway --internet-gateway-id $igw --vpc-id $vpc`
sg=`aws ec2 create-security-group --group-name "MY-Security-Group" --description "My First Time Creating IT Through Shell Script" --vpc-id $vpc | grep -i "groupid" | cut -d ":" -f 2 | cut -d '"' -f 2 `
inbound=` aws ec2 authorize-security-group-ingress --group-id $sg --ip-permissions IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges="[{CidrIp=0.0.0.0/0}]" IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges="[{CidrIp=0.0.0.0/0}]" `

instane=` aws ec2 run-instances --image-id "ami-053b12d3152c0cc71" --instance-type "t2.micro" --subnet-id $subnet --security-group-ids $sg --associate-public-ip-address --key-name NEW-TRY`
