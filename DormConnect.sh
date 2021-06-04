#!/bin/bash
StuID="0123456"
StuPWD="pa55w0rd"


data="username=${StuID}&userpwd=${StuPWD}&btlogin=Continue"



curl 'www.google.com' > /tmp/temp.html

checkStr=$(sed -n 2p /tmp/temp.html | cut -d '"' -f2)
validStr="https://dorm.nycu.edu.tw"

if [[ "${checkStr:0:24}" != "$validStr" ]]; then
  echo Connected
else
  echo LoggingIn
  curl 'https://dorm.nycu.edu.tw/cgi-bin/ace_web_auth.cgi?web_jumpto=&orig_referer=' \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="90", "Google Chrome";v="90"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Origin: https://dorm.nycu.edu.tw' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://dorm.nycu.edu.tw/smsauth/10/pc.php?params=pwd&declare=true' \
  -H 'Accept-Language: zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
  --data-raw "$data" \
  --compressed > /tmp/temp.html
  
  sleep 1
  
  tmp=$(sed -n 3p /tmp/temp.html | cut -d '"' -f2)
  echo $tmp
  curl https://dorm.nycu.edu.tw${tmp} > /tmp/temp.html
  echo LogInComplete
  
fi

rm /tmp/temp.html