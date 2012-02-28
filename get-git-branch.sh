#!/bin/bash
 
GIT_BR=`git symbolic-ref HEAD 2> /dev/null | cut -b 12-`
 
if [ "$GIT_BR" = "" ]; then
    echo -n
else
    echo -n "($GIT_BR)"
fi