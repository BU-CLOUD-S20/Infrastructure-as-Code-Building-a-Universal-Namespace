#!/usr/bin/env bash

## Read input options
while getopts ":d:e:i:z:t:" opt; do
  case ${opt} in
    d) domain="$OPTARG"
    ;;
    e) email="$OPTARG"
    ;;
    i) ip="$OPTARG"
    ;;
    z) zone="$OPTARG"
    ;;
    t) token="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

## Sign up new Upspin user
upspin signup -server=${domain} ${email}
upspin setupdomain -domain=${domain} > records.txt

## Get TXT record
a=`grep 'upspin:' records.txt`
declare -a arr
index=0
for i in $(echo ${a} | awk '{print $1,$2,$3,$4}')
do
arr[$index]=${i}
let "index+=1"
done
txt_record=${arr[3]}

## Create A record
p1='{"type":"A","name":"'
p2='","content":"'
p3='","ttl":120,"priority":10,"proxied":false}'
curl -X POST "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records" \
-H "Authorization: Bearer ${token}" \
-H "Content-Type:application/json" \
--data ${p1}${domain}${p2}${ip}${p3}

## Create TXT record
p1='{"type":"TXT","name":"'
p2='","content":"'
p3='","ttl":900,"priority":10,"proxied":false}'
curl -X POST "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records" \
-H "Authorization: Bearer ${token}" \
-H "Content-Type:application/json" \
--data ${p1}${domain}${p2}${txt_record}${p3}