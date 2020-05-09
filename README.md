# Infrastructure as Code: Building a Universal Namespace

Deploy a global naming system using the idea of **Infrastructure as Code**.

## Description
This project is to automatically deploy a global naming system called [Upspin](https://upspin.io/), on both OpenStack and OpenShift platform.

## Contributors
* Mentor: Patrick Dillon (Red Hat)
* Member: Zeyu Fu, Yang Hu, Shuo Liao, Ting Zhang, Boyang Zhou

## Final Product
* A package of [Ansible playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) (this repo) for deploying on `OpenStack`.
* A Docker file [repo](https://github.com/ZeyuKeithFu/upspin-openshift) for deploying on `OpenShift`.

## Installation Instructions
* [OpenStack installation](./doc/openstack_setups.md)
* OpenShift installation: refer to our OpenShift [repo](https://github.com/ZeyuKeithFu/upspin-openshift)

## Presentations
* Final video
  + [video link](https://www.youtube.com/watch?v=UXmL-Ll2sHI&feature=youtu.be)
  + [slides](https://docs.google.com/presentation/d/1PSZz1MIJzuXC3-Sa0DIfS2ucxKkK4nfCtG7tOHgY0P4)
* Sprint demos
  + [Demo 1](https://docs.google.com/presentation/d/1zNnP6OkI4NMDZuPKl3dQNuUWyhNrMRnywgBcSJUd7_U)
  + [Demo 2](https://docs.google.com/presentation/d/1w_n4y99QZe2VVN9qeA4BEZum3VUbWpFwEDdrX7UvDFE)
  + [Demo 3](https://docs.google.com/presentation/d/1Ufb6Qv-JrNkzeQTv05IKW5BsKxRxs5i_ug7SV_xnYas)
  + [Demo 4](https://docs.google.com/presentation/d/18dvctHLd51uFD5g864v6ZzLd5nr_rCYyJltLJZ9oZ70)
  + [Demo 5](https://docs.google.com/presentation/d/1niz41vEIwC5mgnM38fTNgtGX_oUmGTlhBnhTwuxdUMo)

## Project Documentation
Table of content:
* [1. Vision and Goals Of The Project](#1-vision-and-goals-of-the-project)
* [2. Users/Personas Of The Project](#2-userspersonas-of-the-project)
* [3. Scope and Features Of The Project](#3-scope-and-features-of-the-project)
* [4. Solution Concept](#4-solution-concept)
* [5. Risk Identification](#5-risk-identification)
* [6. Acceptance Criteria](#6-acceptance-criteria)
* [7. Release Planning](#7-release-planning)

---

## 1. Vision and Goals Of The Project
**Deploy a global naming system using the idea of IaC (Infrastructure as Code)**

[**Upspin**](https://upspin.io/): a global naming system   
A framework for naming and sharing files and other data securely, uniformly, and globally.

## 2. Users/Personas Of The Project

This project aims to create an auto-setup service on the Massachusetts Open Cloud (MoC), which enable users to deploy an Upspin server without manually provisioning infrastructures.

Our target user group is personal users who:
* want to manage their data in a secure way
* want to easily share their data with family or friends

## 3. Scope and Features Of The Project
Basic Features:
* Automation: 
  - Upspin server automatically set up by Ansible playbook on MOC
  - Upspin monitored by server admin
  - Infrastructures like computing instances and networking will be provisioned automatically
  - Automate configuration management, workflow & lifecycle orchestration, app deployment
* Security:
  - Upspin: Data are allocated separately where each piece is encrypted individually.     
  - Ansible: Agentless architecture and use of OpenSSH & WinRM of Ansible Playbook

Further high-level features
* Cross-cloud:   
Provide cross-cloud deployment like accessing files in Google Drive from Upspin deployed on MOC.
* Scalability:   
Scale to multiple servers or storages by Ansible playbook
* Extensibility:   
Create an extensible application used to showcase the Upspin’s features.

## 4. Solution Concept
### Project Overview
Data sharing is essential in a group of people, such as associations and companies. Most importantly, people want to share files in a fast, safe and secure manner. Upspin meets the basic requirements of safety and security in sharing data. However, the process of provisioning the Upspin infrastructure on a cloud is complicated and time-consuming. Therefore, provisioning the infrastructure is an impediment for the real-life application of data sharing within a group. More than just making things easier and faster, automating the process with an Ansible playbook can potentially open up the usage for more people with needs. Detials will be further discussed.

![](https://github.com/BU-CLOUD-S20/Infrastructure-as-Code-Building-a-Universal-Namespace/blob/master/doc/Structure%20Diagram.png)

Figure 1: Upspin on cloud architecture. Items are blue are the responsibility of this project. Yellow items are part of the larger IaC project, and are not the responsibility of this project.

![](https://github.com/BU-CLOUD-S20/Infrastructure-as-Code-Building-a-Universal-Namespace/blob/master/doc/Sequence%20Diagram.png)

Figure 2: Sequence diagram of Upspin. 

Our goal is using Ansible to deploy and manage Upspin on MOC. Figure 1 presents our architectural design for the IaC project. User information is stored by key server, an authorization server. Once a user is authenticated by key server, user’s namespace, public key and directory server address will be stored by key server. The namespace will be the only access entry to data. Directory server stores the user’s tree which gives names to data held in storage servers and entries of data. Storage server holds the actual data. As shown in Figure 2, a detailed Upspin plan is presented. As receiving a request, key server will reply with namespace and directory address. When directory server receive request, it will first check the access authority and then reply with storage server address and references to data. When directory server receive request, it will send data blocks. 

Ansible, as part of our project, is a tool for provisioning the infrastructure and configuring Upspin server. Essentially, we will create an Ansible playbook takes required user inputs, such as domain names and credentials. A play for Upspin setup will be orchestrated into tasks, through which will automatically complete the setting up procedures. Currently, an Upspin user who wants to setting up an Upspin account is required to follow these steps manually: signing up for an user account, configuring a domain name and creating an Upspin user for the server, and configuring the server. For additional needs, there are other steps other than what was stated above. These steps can be completed with one play inside our Ansible playbook, so that users will be able to set up Upspin in a faster and more convenient manner. A playbook can contain multiple plays for different functions. After setting up Upspin, there will be other plays for data management through Ansible playbook, such as calculating the storage space that has been requested and currently occupied, and visualizing usage and allocation of usage.

### Design Implications and Discussion
* Using Ansible playbook to simplify Server Setup: An ansible playbook will automate the setup of an Upspin server on MOC. The process of setting up a Upspin server is fairly complicated; a user is required to provision infrastructure and manually a few lines of commands. Our project will simplify the process of server setup for end-users. To set up the server, each end-user will only need to provide essential information and select from provided services. Other work such as provisioning infrastructure and configure the Upspin server will be automated.
* Upspin Deployment: Resources will be deployed by Ansible. Ansible will create containers for directory servers and storage servers, provide their address, monitor their states and automatically manage resources in real time. Once a container (store server) is fully occupied, Ansible will request to open up another container automatically to fulfill the usage requirements.
* Admin-User and End-User Authority: All admin-users are responsible for monitoring and managing resource allocation. Only the requested storage space and utilized storage will be available; details such as where exactly their data are allocated cannot be viewed. 
* Realtime Database Updates: All end-user data, such as service requested and actually used, will be stored in DB, managed and updated either automatically or manually by admin-users.

## 5. Risk Identification
* Major Concern
  - Not enough customization for users   
    There will be limitations on automatic configuration, since users might have needs on options that requires specific customization.
* Secondary Concerns
  - Server stability
  - Security concerns

## 6. Acceptance Criteria
Minimum acceptance criteria is a deployed upspin server on MOC, configured by an Ansible playbook.   
If time permits, stretch goals are:
* Ansible Playbooks to scale either servers or storage
* Use an external storage volume in the MOC
* Cross-cloud deployment (e.g. access files in Google Drive from Upspin deployed on MOC)
* Create an application to showcase Upspin’s features (e.g. gmail plugins)

## 7. Release Planning
* Release 1 (due by Week 5)   
  Ansible playbook with necessary infrastructure in MOC (e.g. authentication, instance management etc,.)
* Release 2 (due by Week 7)    
  Deployed Upspin server on MOC
* Release 3 (due by Week 9)   
  Ansible playbook that automate the configurations of Upspin server
* Release 4 (due by Week 11)      
  Upspin deployment using Openshift
* Release 5 (due by Week 13)   
  Implement future works as listed in future development

## References
* [Upspin](https://upspin.io/doc/)
* [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html)