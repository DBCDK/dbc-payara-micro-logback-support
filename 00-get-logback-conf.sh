#!/bin/bash
curl -L -o config/logback-included.xml --fail $LOGBACK_URL

if [ $? -eq 0 ]; then
    echo "===> fetched logback url:${LOGBACK_URL}"
else
    echo "===> Logback not found or not stated"
fi

echo "===> Using this logback.xml:"
cat config/logback-included.xml
