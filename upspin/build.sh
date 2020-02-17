#!/usr/bin/env bash

## Download Upspin packages
sudo wget https://upspin.io/dl/upspin.darwin_amd64.tar.gz
sudo tar -C /usr/local/bin -xzf upspin.darwin_amd64.tar.gz

## Sign up new Upspin user
echo "Please enter your Upspin domain:"
read domain
echo "Please enter your email address:"
read email
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
rm -f records.txt

## Create sub-domain
echo "Please enter your ip address:"
read ip_address
p1='{"type":"A","name":"'
p2='","content":"'
p3='","ttl":120,"priority":10,"proxied":false}'
curl -X POST "https://api.cloudflare.com/client/v4/zones/6c6c793898e1697f199bc5676c3ddeda/dns_records" \
-H "Authorization: Bearer hpkceho27CpiMbj5x-1FRiemifeVVwSby0mo5n-w" \
-H "Content-Type:application/json" \
--data ${p1}${domain}${p2}${ip_address}${p3}

## Create DNS record
p1='{"type":"TXT","name":"'
p2='","content":"'
p3='","ttl":900,"priority":10,"proxied":false}'
curl -X POST "https://api.cloudflare.com/client/v4/zones/6c6c793898e1697f199bc5676c3ddeda/dns_records" \
-H "Authorization: Bearer hpkceho27CpiMbj5x-1FRiemifeVVwSby0mo5n-w" \
-H "Content-Type:application/json" \
--data ${p1}${domain}${p2}${txt_record}${p3}

## Build runnable binary
go get 'upspin.io/cmd/...'
GOOS=linux GOARCH=amd64 go build upspin.io/cmd/upspinserver
scp upspinserver upspin@${domain}:upspinserver

## Setup server
echo "[Unit]
Description=Upspin server

[Service]
ExecStart=/home/upspin/upspinserver
User=upspin
Group=upspin
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/upspinserver.service
setcap cap_net_bind_service=+ep /home/upspin/upspinserver
systemctl enable --now /etc/systemd/system/upspinserver.service