## Prerequisites:
* Install Golang on your local machine
* Install Upspin package on your local machine
* Sign up for a new Upspin account

## Configuration:
* /etc/ansible/hosts   
Provide your server ips in hosts file, an example can be:
    ```ini
    127.0.0.1

    [upspin]
    128.XX.XX.XX ansible_user=USERNAME
    ```
* roles/openstack/vars/auth_vars.yml   
Create a `auth_vars.yml` file to provide required SSO authentication vars for OpenStack platform, as the following format:
    ```yml
    ---
    # All private authentication variables

    username: ""
    password: ""
    project_name: ""
    client_id: ""
    client_secret: ""
    client_key: ""
    ```
* roles/upspin/vars/config_vars.yml   
Create a `config_vars.yml` file to provide all necessary configurations for an Upspin server, as the following format:
    ```yml
    ---
    # All configuration variables for an Upspin tasks

    # Server IP
    ip: 128.XX.XX.XX

    # Upspin
    domain: FZY

    # CloudFlare
    zone: mocupspin.com
    token: ""
    account_email: XXX@gmail.com
    ```
* ~/upspin/config   
Set up your `config` file under upspin package, provide your Upspin account information. An example can be:
    ```
    keyserver: remote,key.upspin.io:443

    username: XXX@gmail.com
    storeserver: remote,XXX.mocupspin.com:443
    dirserver: remote,XXX.mocupspin.com:443
    packing: ee
    ```

## Start
1. Create a new server on OpenStack:
    ```
    ansible-playbook roles/openstack/tasks/main.yml
    ```
2. Setup Upspin server:
    ```
    ansible-playbook roles/upspin/tasks/main.yml
    ```
3. If you want to enable logging:
    ```
    ansible-playbook main.yml -vvv
    ```