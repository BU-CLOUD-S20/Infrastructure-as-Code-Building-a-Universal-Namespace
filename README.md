# Infrastructure as Code: Building a Universal Namespace

## 1. Vision and Goals Of The Project

In this project, we will create an ansible playbook that automates the setup of an Upspin server on the Massachusetts Open Cloud. We mainly focus on:
* Creating necessary infrastructure in MoC (OpenStack)
* Deploying and configure Upspin

Further development:
* Create an application to scale either servers or storage based on playbook
* Use an external storage volume in the MoC
* Cross-cloud deployment, e.g. access files in Google Drive from Upspin deployed on MoC
* Create an application or use that showcases Upspin's features 

## 2. Users/Personas Of The Project

The IaC project aims to create an auto-setup service on the Massachusetts Open Cloud (MoC), which enable users to deploy an Upspin server without manually provisioning infrastructures.   
Our target user groups include:
* Server provider   
  Upspin server providers who manage all the resources
* End user   
  Upspin server users who save/retrieve/share files with customized configurations

## 3. Scope and Features Of The Project

### Minimum Value Product Features:
* User Interface
    + UI for admin user (invisible to end user):
        + Manage the container
        + Monitor server usage
    + UI for end user:
        + Authentication
        + Customize service 
        + View resource allocation
        + User friendly: easy to upload files, access files and manage the configuration of Upspin

* Automation: 
     + Upspin server automatically set up by Ansible playbook on MOC
     + Upspin monitored by admin user
     + Infrastructures like computing instances and networking will be provisioned automatically
     + Automate configuration management, workflow & lifecycle orchestration, app deployment

* Security: 
     + Upspin: Data are allocated separately where each piece is encrypted individually.     
     + Ansible: Agentless architecture and use of OpenSSH & WinRM of Ansible Playbook

### Further high-level features
* Cross-cloud: 
Provide cross-cloud deployment like accessing files in Google Drive from Upspin deployed on MoC.
* Scalability: 
Scale to multiple servers or storages by Ansible playbook
* Extensibility: 
Create an extensible application used to showcase the Upspin’s features.


## 4. Solution Concept
Global Architectural Structure Of the Project:

* Upspin: commercial web services provided in a safe, secure and sharable way
  - Key server: centralized key server which all users are connected to 
  - Directory server: a hierarchical tree of names pointing to user data
  - Store server: data storage (possibly encrypted)

* Ansible: automation tool for infrastructure deployment
  - Task: the application of a module to process a unit of work
  - Play: ordered set of tasks to execute against host selections from your inventory
  - Playbook: a file that contains plays
 
* UI: A simplified workflow presentation facing users

* Database: User data and service record

![](https://github.com/BU-CLOUD-S20/Infrastructure-as-Code-Building-a-Universal-Namespace/blob/master/doc/Structure%20Diagram.png)

Figure 1: Upspin on cloud architecture. Items are blue are the responsibility of this project. Yellow items are part of the larger IaC project, and are not the responsibility of this project.

![](https://github.com/BU-CLOUD-S20/Infrastructure-as-Code-Building-a-Universal-Namespace/blob/master/doc/Sequence%20Diagram.png)
Figure 2: Sequence diagram of Upspin. 

Our goal is using Ansible to deploy and manage Upspin on MOC. Figure 1 presents our architectural design for the IaC project. User information is stored by key server, an authorization server. Once a user is authenticated by key server, user’s namespace, public key and directory server address will be stored by key server. The namespace will be the only access entry to data. Directory server stores the user’s tree which gives names to data held in storage servers and entries of data. Storage server holds the actual data. As shown in Figure 2, a detailed Upspin plan is presented. As receiving a request, key server will reply with namespace and directory address. When directory server receive request, it will first check the access authority and then reply with storage server address and references to data. When directory server receive request, it will send data blocks. 

Ansible, as part of our project, is a tool for provisioning the infrastructure and configuring Upspin server. Essentially, we will create an Ansible playbook takes required user inputs, such as domain names and credentials. A play for Upspin setup will be orchestrated into tasks, through which will automatically complete the setting up procedures. For now, an Upspin user who wants to setting up an Upspin account is required to follow these steps manually: signing up for an user account, configuring a domain name and creating an Upspin user for the server, and configuring the server. For additional needs, there are other steps other than what was stated above. These steps can be completed with one play inside our Ansible playbook, so that users will be able to set up Upspin in a faster and more convenient manner. A playbook can contain multiple plays for different functions. After setting up Upspin, there will be other plays for data management through Ansible playbook, such as calculating the storage space that has been requested and currently occupied, and visualizing usage and allocation of usage.

* Design Implications and Discussion
  - Using Ansible playbook to simplify Server Setup: An ansible playbook will automate the setup of an Upspin server on MOC. The process of setting up a Upspin server is fairly complicated; a user is required to provision infrastructure and manually a few lines of commands. Our project will simplify the process of server setup for end-users. To set up the server, each end-user will only need to provide essential information and select from provided services. Other work such as provisioning infrastructure and configure the Upspin server will be automated.
  - Upspin Deployment: Resources will be deployed by Ansible. Ansible will create containers for directory servers and storage servers, provide their address, monitor their states and automatically manage resources in real time. Once a container (store server) is fully occupied, Ansible will request to open up another container automatically to fulfill the usage requirements.
  - Admin-User and End-User Authority: All admin-users are responsible for monitoring and managing resource allocation. Only the requested storage space and utilized storage will be available; details such as where exactly their data are allocated cannot be viewed. 
  - Realtime Database Updates: All end-user data, such as service requested and actually used, will be stored in DB, managed and updated either automatically or manually by admin-users.

## 5. Acceptance Criteria
Minimum acceptance criteria is a deployed upspin server on MOC, configured by an Ansible playbook.   
If time permits, stretch goals are:

* Playbook to scale either servers or storage
* Use an external storage volume in the MoC
* Cross-cloud deployment (e.g. access files in Google Drive from Upspin deployed on MoC)
* Create an application to showcase Upspin’s features (e.g. gmail plugins)

## 6. Release Planning
* Release 1 (due by Week 5)   
  Ansible playbook with necessary infrastructure in MoC (e.g. authentication, instance management etc,.)
* Release 2 (due by Week 7)   
  Deployed Upspin server on MoC
* Release 3 (due by Week 9)   
  Ansible playbook that automate the configurations of Upspin server
* Release 4 (due by Week 11)   
  UI for both admin user and end user
* Release 5 (due by Week 13)   
  Implement future works as listed in future development
