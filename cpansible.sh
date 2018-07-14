#!/bin/bash
sed -i '/with_items/ ,/name/{//!d}' play-book/copy.yml
clear
while [ "${yn}" != "n" -o "${yn}" != "N" ]
do
a=$(($a+1))
printf "Please push any key to execute, or push \033[35mn/N\033[0m to exit: " && read yn
case $yn in
[n,N])
    printf "\n\033[37mExit now!!\033[0m\n"
    break ;;
*)
printf "\nInput a \033[37msource\033[0m file/folder name it's on the local, it will be copied to the remote host: " && read source
if [ ! -d "$source" ] && [ ! -f "$source" ]; then
  printf "\n\033[31mThe soruce directory or file dose not exist.\033[0m\nPush any key to re-input." && read p
  elif [ -d "$source" ]; then
    tree $source -fapugDC -L 1
    printf "\nInput a \033[33mdestination\033[0m path you want to copy to: " && read dest
    printf "\nSpecify \033[36mpermissions\033[0m for the destination folder copied for(for a example 600 or 755): " && read perm
    printf "\n=== Your input ===\n\033[37mSource: $source\nDestination: $dest\nPermission: $perm\033[0m\n=================="
    printf "\nPlease confirm your input is correct in below, and push \033[35my/Y\033[0m to continue, or push \033[35mn/N\033[0m to re-input: "
    while [ "${yn1}" != "y" -o "${yn1}" != "Y" -o "${yn1}" != "n" -o "${yn1}" != "N" ]
    do
    i=$(($i+1))
    read yn1
    case $yn1 in
    [y,Y])
	sed -i "/with_items/a\      \- { src: '"$source"',\ \dest: '"$dest"',\ \mode: '"$perm"'}" play-book/copy.yml
	printf "\nYes, all the input was correctly.\n"
	break ;;
    [n,N])
	printf "\nNo, incorrectly !! I will be going to input again.\n"
	break ;;
    esac
    done
  elif [ -f "$source" ]; then
    ls -al $source
    printf "\nInput a \033[33mdestination\033[0m path you want to copy to: " && read dest
    printf "\nSpecify \033[36mpermissions\033[0m for the destination file copied for(for a example 600 or 755): " && read perm
    printf "\n=== Your input ===\n\033[37mSource: $source\nDestination: $dest\nPermission: $perm\033[0m\n=================="
    printf "\nPlease confirm your input is correct in below, and push \033[35my or Y\033[0m to continue, or push any key to re-input: "
    while [ "${yn2}" != "y" -o "${yn2}" != "Y" -o "${yn2}" != "n" -o "${yn2}" != "N" ]
    do
    j=$(($j+1))
    read yn2
    case $yn2 in
    [y,Y])
	sed -i "/with_items/a\      \- { src: '"$source"',\ \dest: '"$dest"',\ \mode: '"$perm"'}" play-book/copy.yml
        printf "\nYes, all the input was correctly.\n"
	break ;;
    [n,N])
        printf "\nNo,incorrectly !! I will be going to input again.\n"
	break ;;
    esac
    done
fi
;;
esac
done
