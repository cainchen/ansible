#!/bin/bash
export ANSIBLE=/Users/cainchen/Ansible
while true; do
i=0
clear
grep -i "inventory =" $ANSIBLE/ansible.cfg >/dev/null 2>&1
if [ $? -gt 0 ]
then
    sed -i "2iinventory = $ANSIBLE/inventory/hosts" $ANSIBLE/ansible.cfg
fi
tree $ANSIBLE/inventory
printf "\nSelect a \033[40;36minventory file\033[0m from aboved list, and input to: " && read inventory
sed -i '2d' $ANSIBLE/ansible.cfg && sed -i "2iinventory = $ANSIBLE/inventory/$inventory" $ANSIBLE/ansible.cfg
printf "\n"
cat $ANSIBLE/inventory/$inventory
if [ $? -gt 0 ]
then
    printf "\n\033[31mSpecified inventory file not exist, stopped now !\033[0m\n\n"
    exit 1;
fi
printf "\nInput a \033[37mserver group\033[0m from aboved list: " && read group
#while true; do
#i=0
  while [ "${go}" != "a" -o "${go}" != "p" ]
  do
   i=$(($i+1))
   printf "\nOnly need to execute a command usring a module, push \033[35ma\033[0m."
   printf "\nOr, play a play-book, push \033[33mp\033[0m.\n"
   printf "\nYour choose \033[34m?\033[0m " && read go
   case $go in
   [a])
      printf "\nInput a command then push the 'Enter' key for running: " && read cmd
      ansible $group -m raw -a "$cmd" -s -vvv
      break ;;
   [p])
      printf "\n=== Your play-book ===\n"
      ls -al $ANSIBLE/play-book/*.yml | awk -F"/" '{print $6}' | sort -n
      #tree -i $ANSIBLE/play-book/ | sed -e '1d'
      printf "\nInput a play-book file name (not need the .yml) for running: " && read book
      ansible-playbook $ANSIBLE/play-book/$book.yml --extra-vars "hosts=$group user=cainchen"
      break ;;
  esac
      printf "Your input must to be 'a' or 'p' !"
  done
 read -p "Push any key to again. Or input 'n' for exiting." end
 case $end in
 [n]) printf "Exited now.\n\n"
      break;;
 esac
done
