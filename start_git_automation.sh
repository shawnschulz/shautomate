#!/bin/bash

AUTOMATION_LIST="/home/bankerz/bash_scripts/automation_list.config"
CHECK_IN_LIST=$(grep . $AUTOMATION_LIST)

if ! [[ -z ${CHECK_IN_LIST} ]]; then
    echo "Directory already in automation list"
elif [[ "true" -eq "$(git rev-parse --is-inside-work-tree)" ]]; then
    touch git_automation.config
    if [ $(wc -l < ${AUTOMATION_LIST}) -gt 100 ]; then
        tail -n +2 ${AUTOMATION_LIST} > ${AUTOMATION_LIST}
    fi
    echo $(pwd) >> ${AUTOMATION_LIST}
else
    echo "Current dir is not a git repository."
fi




