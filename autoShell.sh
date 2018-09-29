#!/bin/sh

if [ $# -eq 1 ]; then
	remoteip=$1
elif [ $# -eq 2 ]; then
	username=$2
	remoteip=$1
else
	echo "input the parameter is not right!!!"
	echo "example: autossh 192.168.1.100 username"
	echo "         autossh list"
fi

if [ $remoteip = "list" ]; then
	list=$(cat ./storeRemoteIp.txt)
	echo $list
	exit 0
fi

output=$(python readfile.py $remoteip $username)

filter=$(echo $output | sed -e 's/.*result:\(.*\)/\1/g')
echo $filter
result=$(echo $filter | sed -e 's/^\([^,]*\).*/\1/g')
user=$(echo $filter | sed -e 's/^[^,]*,\([^,]*\).*/\1/g')

if [ $result = "false" ]; then
	echo "copy public key into the remote server"
	cat ~/.ssh/id_rsa.pub | ssh $user@$remoteip "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
	ssh $user@$remoteip
else
	echo "connect the server directly"
	ssh $user@$remoteip
fi
