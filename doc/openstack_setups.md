## Prerequisites:
* Install Ansible
    - Refer to [this link](https://docs.ansible.com/ansible/latest/installation_guide/)
* Install Golang on your local machine 
    - Refer to [this link](https://golang.org/doc/install)
* Install Upspin package on your local machine
    - Download package from [here](https://upspin.io/dl/)
    - Run ```tar -C /usr/local/bin -xzf upspin.linux_amd64.tar.gz``` to upzip and install
* Sign up for a new Upspin account
    - Follow the [link](https://upspin.io/doc/signup.md)

## Configuration:
* roles/openstack/vars/auth_vars.yml   
Create a `auth_vars.yml` file to provide required SSO authentication vars for OpenStack platform, as the following format:
    ```yml
    ---
    # All private authentication variables

    client_key: XXX
    auth:
      auth_url: 'xxx'
      username: 'xxx'
      password: 'xxx'
      project_name: 'xxx'
      identity_provider: moc
      protocol: xxx
      client_id: xxx
      client_secret: xxx
      access_token_endpoint: 'xxx'
      discovery_endpoint: 'xxx'
      user_domain_name: ''
      project_domain_name: Default
    ```
* roles/upspin/vars/config_vars.yml   
Create a `config_vars.yml` file to provide all necessary configurations for an Upspin server, as the following format:
    ```yml
    ---
    # All configuration variables for an Upspin tasks

    domain: XXX
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
**Make sure your domain name in roles/upspin/vars/config_vars.yml is the same as in ~/upspin/config**  
## Start
Run:
```
ansible-playbook site.yml
```
Use `-vvv` to enable different level of verbose logging.