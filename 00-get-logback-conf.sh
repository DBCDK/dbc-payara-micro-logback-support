#!/bin/bash
curl -L -o $LOGBACK_CONF_FILE --fail $LOGBACK_URL

if [ $? -eq 0 ]; then
    echo "===> fetched logback url:${LOGBACK_URL}"
else
    echo "===> Logback not found or not stated"
fi

echo "===> Using this logback.xml:"
cat $LOGBACK_CONF_FILE 
