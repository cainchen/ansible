#!/bin/bash
ip=$(cat $ANSIBLE/play-book/hosts)
for i in $ip; do
 ansible-playbook $ANSIBLE/play-book/ping-noti-slack.yml -e hosts=$i
done
