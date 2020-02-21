#!/usr/bin/env bash

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