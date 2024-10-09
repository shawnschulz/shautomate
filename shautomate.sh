#!/bin/bash

shautomate_dir=/home/bankerz/bash_scripts/shautomation/

print_usage() {
    printf "Usage: shautomate [options]
            options:
            -i run default initialization configuration for shautomate
            -r run quicksave
            -a add current directory to autosave \n"
}

i_flag=''
r_flag=''
a_flag=''

while getopts 'ira:v' flag; do
  case "${flag}" in
    i) i_flag='true' ;;
    r) r_flag='true' ;;
    a) a_flag="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

if ! [ -z $i_flag ]; then
    bash ${shautomate_dir}/initialize.sh
elif ! [ -z $r_flag ]; then
    bash ${shautomate_dir}/git_automation.sh
elif ! [ -z $a_flag ]; then
    cd ${a_flag}
    bash ${shautomate_dir}/start_git_automation.sh
else
    print_usage
fi
