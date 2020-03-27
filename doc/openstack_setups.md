## Prerequisites:
* Install Golang on your local machine
* Install Upspin package on your local machine
* Sign up for a new Upspin account

## Configuration:
* roles/openstack/vars/auth_vars.yml   
Create a `auth_vars.yml` file to provide required SSO authentication vars for OpenStack platform, as the following format:
    ```yml
    ---
    # All private authentication variables

    client_key: XXX
    auth:
      username: ""
      password: ""
      project_name: ""
      ...
    ```
* roles/upspin/vars/config_vars.yml   
Create a `config_vars.yml` file to provide all necessary configurations for an Upspin server, as the following format:
    ```yml
    ---
    # All configuration variables for an Upspin tasks

    domain: FZY
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
Run:
```
ansible-playbook site.yml
```
Use `-vvv` to enable different level of verbose logging.