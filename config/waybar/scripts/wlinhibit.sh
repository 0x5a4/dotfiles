#!/usr/bin/env bash

if pidof wlinhibit &> /dev/null; then 
    echo '{"text":""}'
else
    echo '{"text":"", "class":"deactivated"}'
fi
