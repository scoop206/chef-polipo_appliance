#!/bin/bash

# bootsrap polipo appliance

echo
echo ">> starting up polipo appliance"
echo 

vagrant destroy -f
vagrant up

echo
echo ">> polipo appliance ip address:"
echo 

# retreive the ip and output to file if we have an argument
bundle exec vagrant ssh -c ifconfig | grep -A 3 eth1 | grep inet\ addr | cut -d: -f2 | awk '{ print $1 }' | tee $1


