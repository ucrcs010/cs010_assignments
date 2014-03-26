#!/bin/bash
FORM_LOCATION="https://docs.google.com/forms/d/10yunl8d4HkAx6WfHEdarhKhK-9vc4VKY8f3qY64YC6Q/formResponse"
CODE_AREA="entry.1644658506"
ERROR_AREA="entry.727705083"
RSUB_EMAIL_AREA="entry.1527918066"
errors=$(g++ $* 2>&1)

if [ "${errors}" != "" ] 
then
    if [ "${UCRCS_COURSE}" == "CS010" -o "${UCRCS_COURSE}" == "CS010v" ]
    then
        for var in "$@"
        do
            cp $var tmp.cpp
            myerrs=$(g++ tmp.cpp 2>&1)
            sed -i "1,/END ASS/d" tmp.cpp
            value=$(cat tmp.cpp)        
            rm tmp.cpp
            if [ "$value" == "" ]
            then
                value=$(cat $1)
            fi
            code_val="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$value")"
            err_val="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$myerrs")"
            rsub_val="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$UCRCS_UCRSUB_EMAIL")"        
            curl "${FORM_LOCATION}?${CODE_AREA}=${code_val}&${ERROR_AREA}=${err_val}&${RSUB_EMAIL_AREA}=${rsub_val}" &>/dev/null
        done
    fi
    echo "$errors"
fi