#!/bin/bash

function cp_files(){
    cp -f index.html _book/index.html
    cp -f assets/sipeed/favicon.ico _book/gitbook/images/favicon.ico
    cp -f assets/sipeed/sipeed_logo.png _book/gitbook/images/apple-touch-icon-precomposed-152.png
}

success_str='Serving book on'
while [ 0 ];
do
a=`cat serve.tmp |grep "$success_str"`
b=`cat serve.tmp|grep "Error"`

if [[ "x$a" != "x" ]]; then
    cp_files
    `echo "">serve.tmp`
elif [[ "x$b" != "x" ]]; then
    exit 0
fi
sleep 1s
if ! [[ -f serve.tmp ]]; then
    exit 0
fi
done
