#!/usr/bin/env bash

#prerequisites:
# npm install -g pomojs clocker

#Usage
#arg1 title of task (use dashes for now rather than spaces)
#arg2 time of task
#arg3 (optional) boolean including of 5 min meditation
#ex to do work for 25 mins and then mediate for 5 mins:
#$ clocker-pom.sh "review-cam's-code-2" 25 1

#Sample run:
#$ clocker-pom.sh "devise-some-tests-2" 25 1


function track(){
  TITLE=$1
  MINS=$2

  local FULL_TITLE="$TITLE for $MINS mins"
  echo  $FULL_TITLE
  clocker start -t $FULL_TITLE

  echo "clocker stop ;  player play $BEEPMP3"  | at now +$MINS minutes ; pomojs -d $MINS $TITLE


}

#------------------------
#Main
track $1 $2;

#add a meditate for five mins
MEDITATE_5=$3
if [ $MEDITATE_5 -eq 1  ]
then
  track "Meditate recovery" 5;
fi


#Currently Linux only by default (uses notify-send, haven't found cross platform notifier yet). To use cross platform, simply swap the current notify-send command below with your command line notification for use in other os's (for example terminal-notifier on Mac ). May use node-notifier change if mikaelbr/node-notifier/issues/40 gets implemented.
