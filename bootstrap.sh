#!/bin/bash

# bootsrap polipo appliance

echo
echo ">> starting up polipo appliance"
echo 

bundle install
bundle exec vagrant destroy -f
bundle exec vagrant up

echo
echo ">> polipo appliance ip address:"
echo 

bundle exec vagrant ssh -c ifconfig | grep -A 3 eth1 | grep inet\ addr | cut -d: -f2 | awk '{ print $1 }'
echo

