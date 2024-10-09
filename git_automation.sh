#!/bin/bash

LAST_RUN="/home/bankerz/bash_scripts/last_run.txt"

#by default, will only even try to check the last 100 repositories
#added to automation_list
AUTOMATION_LIST="/home/bankerz/bash_scripts/automation_list.config"

LAST_RUNTIME=$(cat ${LAST_RUN})

for fp in $(cat ${AUTOMATION_LIST}); do

    LAST_MODIFIED=$(date -r $fp +%Y%m%d%H%M%S)
    
    if [ $LAST_RUNTIME -ge $LAST_MODIFIED ]; then
        #Don't bother autosaving if the last runtime was after last
        #modification time
        :

    elif test -f ./git_automation.config; then

        cd $fp

        DATETIME=$(date +%Y%m%d%H%M%S)

        echo "git_automation.config found, running git automations"

        FILES=$(find . \( ! -regex '.*/\..*' \) \( -not -name "*temp*" -and -not -path '"*/."' \))

        for fp in $FILES;
        do
            git add ${fp}
        done

        CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

        git switch -c autosave

        git switch autosave

        git commit -a -m "Autosave at time: ${DATETIME}"

        git push --set-upstream origin autosave

        git checkout ${CURRENT_BRANCH}

    fi

done

NEW_RUNTIME=$(date +%Y%m%d%H%M%S)

echo ${NEW_RUNTIME} > "/home/bankerz/bash_scripts/last_run.txt"
