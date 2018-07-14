#!/bin/bash
export FOLDER=/Users/cainchen/Ansible
export SSH_KEY=/Users/cainchen/Ansible/ssh_key
sed -i '/vars:/ ,/tasks/{//!d}' play-book/adduser.yml && sed -i '/vars:/a\    \group_vars: newgp' play-book/adduser.yml
sed -i '/with_items/ ,/name/{//!d}' play-book/adduser.yml
sed -i '/Grant/ ,/validate/s/^#//g' play-book/adduser.yml
rm -f $FOLDER/newuser.tmp
clear
yn2="null"
until [ "$yn2" = "y" ] || [ "$yn2" = "Y" ]
do
  printf "\nInput a \033[37mgroup name\033[0m ,it's you want to new account will be joined to: " && read group
  yn1="null"
  until [ "$yn1" = "Y" ] || [ "$yn1" = "N" ]
  do
    printf "\nDo you grant this group [\033[44m\033[37m$group\033[0m] it's can passwordless to upgrade to sudo privileges[\033[40m\033[31mY/N\033[0m]? " && read yn1
    if [ "$yn1" == "Y" ]; then
      sed -i '/Grant/ ,/validate/s/^#//g' play-book/adduser.yml
      break
    elif [ "$yn1" == "N" ]; then
      sed -i '/Grant/ ,/validate/s/^/#/' play-book/adduser.yml
      break
    else
      printf "\n\033[40m\033[37mYour input should be [\033[31mY/\033[31mN\033[0m]."
      continue
    fi
  done
  yn2="null"
  until [ "$yn2" = "y" ] || [ "$yn2" = "Y" ]
  do
    printf "\n=== Your input ===\n\033[37mGROUP: $group\nSUDO: $yn1\033[0m\n================="
    printf "\nIf your input shown in above are correct, push [\033[40m\033[31my/Y\033[0m] to continue.\nOr push [\033[40m\033[31mn/N\033[0m] to re-input: " && read yn2
    if [ "$yn2" == "y" ] || [ "$yn2" == "Y" ]; then
      sed -i "s/newgp/$group/g" play-book/adduser.yml
      break
    elif [ "$yn2" == "n" ] || [ "$yn2" == "N" ]; then
      printf "\nNo,incorrectly!! Let's re-input again."
      break
    else
      printf "\n\033[40m\033[37mYour input should be [\033[31mY/\033[31mN\033[0m]."
      continue
    fi
  done
done
until [ "$yn3" = "y" ] || [ "$yn3" = "Y" ]
do
  yn3="null"
  account="null"
  until [ "$account" = "stop" ]
  do
    printf "\nInput an account name, or input \033[35mstop\033[0m for stopped inputting: " && read account
    sed -i "/with_items/a\      \- $account" play-book/adduser.yml
    if [ -f "$SSH_KEY/$account" ]; then
      printf "\n\033[34m$account\033[0m's public key has existed."
      echo "KEY:[V] -- $account" >> $FOLDER/newuser.tmp
    elif [ "$account" == "stop" ]; then
      if [ -f "$FOLDER/newuser.tmp" ]; then
        printf "\nBelow account will be adding to the destination host."
        printf "\n===========\n"
        cat $FOLDER/newuser.tmp | sort -n
	sed -i '/stop/d' play-book/adduser.yml
        printf "\n===========\n"
      else
        printf "\n\033[31mYou haven't add any account!!\033[0m"
      fi
      printf "\nDo you want to exit? Push any key to add account or push [\033[40m\033[31my/Y\033[0m] to exit: " && read yn3
      if [ "$yn3" == "y" ] || [ "$yn3" == "Y" ]; then
	printf "\n\033[37mExit now!!\033[0m\n"
        exit 1
      else
	break
      fi
    else
      printf "\n\033[48m\033[31m$account public key not found.\033[0m First you should be get it and saved to path [\033[37m$SSH_KEY\033[0m] and named the [\033[34m$account\033[0m]."
      echo "KEY:[X] -- $account" >> $FOLDER/newuser.tmp
    fi
  done
done
