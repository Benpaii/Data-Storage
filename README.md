## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.
![Untitled Diagram drawio](https://user-images.githubusercontent.com/95262494/161680490-24ca5728-5ee3-4468-8a00-3d5c8b39fc76.png)

 

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _Untitled Diagram.draw.io____ file may be used to install only certain pieces of it, such as Filebeat.

 Enter the playbook file._

(filebeat-playbook.yml)
---
- name: Installing and Launch Filebeat
  hosts: webservers
  become: yes
  tasks:
    # Use command module
  - name: Download filebeat .deb file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb

    # Use command module
  - name: Install filebeat .deb
    command: dpkg -i filebeat-7.6.1-amd64.deb

    # Use copy module
  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

    # Use command module
  - name: Enable and Configure System Module
    command: filebeat modules enable system

    # Use command module
  - name: Setup filebeat
    command: filebeat setup

    # Use command module
  - name: Start filebeat service
    command: service filebeat start

    # Use systemd module
  - name: Enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes


(metric-playbook.yml)
---
- name: Install metric beat
  hosts: webservers
  become: true
  tasks:
    # Use command module
  - name: Download metricbeat
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.4.0-amd64.deb

    # Use command module
  - name: install metricbeat
    command: dpkg -i metricbeat-7.4.0-amd64.deb

    # Use copy module
  - name: drop in metricbeat config
    copy:
      src: /etc/ansible/files/metricbeat-config.yml
      dest: /etc/metricbeat/metricbeat.yml

    # Use command module
  - name: enable and configure docker module for metric beat
    command: metricbeat modules enable docker

    # Use command module
  - name: setup metric beat
    command: metricbeat setup

    # Use command module
  - name: start metric beat
    command: service metricbeat start

    # Use systemd module
  - name: Enable service metricbeat on boot
    systemd:
      name: metricbeat
      enabled: yes


This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly ___Available__, in addition to restricting __Access___ to the network.
What aspect of security do load balancers protect? What is the advantage of a jump box?
Load Balancers protect against denial of serice attacks (DoS) because the load balanacer analyzes the traffic coming in and determines what server to send the traffic to.

The adanvantage of a jump box is a jump box limits the access that the public has to your virtual network because in order to access the other virtual machines, and individual needs the private IPs of the machines.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _____ and system _____.
What does Filebeat watch for?_  Filesbeat looks for changes in files and when they occured by looking at log files because Filebeat generates and organized log files.

What does Metricbeat record?_ Metricbeat records metrics from the Operating system and services running on the server.
 
The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.


| Name       | Function                    | IP Address | Operating System |
|------------|-----------------------------|------------|------------------|
| Jump Box   | Gateway                     | 10.0.0.1   | Linux            |
| WEB 1      | Server for DVWA             | 10.0.0.8   | Linux            |
| WEB 2      | Server for WVWA             | 10.0.0.9   | Linux            |
| ELK-SERVER | Run Elk & Kibana Containers | 10.1.0.4   | Linux            |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _Jump-Box-Provisioner____ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
Add whitelisted IP addresses_ 104.220.211.210 my public ip.

Machines within the network can only be accessed by _Jump-Box-Provisoner__VM__.

Which machine did you allow to access your ELK VM? Jump-Box-Provisioner
 
What was its IP address?_ 20.106.78.25

A summary of the access policies in place can be found in the table below.


| Name          | Publicly Accessible | Allowed IP Addresses |
|---------------|---------------------|----------------------|
| Jump Box      | Yes                 | 10.0.0.8 & 10.0.0.9  |
| ELK           | Port 5601           | 104.220.211.210      |
| Load Balancer | Port 80             | 104.220.211.210      |
| Web-1         | No                  | 10.0.0.4             |
| Web-2         | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
What is the main advantage of automating configuration with Ansible?_ 
It prevents having to configure ELK manually, it also allows more control over whats being installed or performed on.

The playbook implements the following tasks:
-  In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
-  Install docker.io on ELK VM
-  Install pip3 on ELK VM 
-  Install Docker python module
-  Increase memory to 262144
-  Download and launch a docker

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
 

Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

(Desktop/Project Folder/elk-server docker ps.png)


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
List the IP addresses of the machines you are monitoring_
10.0.0.8 and 10.0.0.9
We have installed the following Beats on these machines:
Specify which Beats you successfully installed_
Filebeat and Metricbeat
These Beats allow us to collect the following information from each machine:
In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
Filebeat is used to collect log files from specific files on remote machines. If u wanted to see the output from Filebeat, you would use kibana and check the logs for any changes that have been made in either a specific time or file system.
Metricbeat shows statistics for every process running on your system (cpu, network, disk, memory). You need to select the system you'd like to review in kibana and go to the metrics system.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
"FileBeat"

- Copy the _filebeat-config.yml____ file to _/etc/ansible/files/filebeat-config.yml____.
- Update the _filebeat-config.yml____ file to include... the ELK private IP in lines 1106 and 1806.
- Run the playbook, and navigate to 
_http://20.232.43.63:5601/__(ELK Pub IP)_ to check that the installation worked as expected.
"Metricbeat"

- Copy the _metricbeat-configuration.yml____ file to _/etc/ansible/roles/files____.
- Update the _metricbeat-configuration.yml____ file to include... ELK private IP on lines 62 and 96
- Run the playbook, and navigate to _http://20.232.43.63:5601/_(ELK pub ip)__ to check that the installation worked as expected.

Answer the following questions to fill in the blanks:_ 
- _Which file is the playbook? filebeat-playbook.yml
Where do you copy it?_ /etc/ansible/roles
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
specify two groups one being the will be the webservers which have the IP's of the VMs that you install Filebeat to.
Other group is named ELK-SERVER which will have the IP and VM i install ELK to we also have to specify the host to the ELK server for Filebeat so IP "10.1.0.4" is added to the config file to specify the location for installation.
- _Which URL do you navigate to in order to check that the ELK server is running?
http://20.232.43.63:5601/
_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
"FileBeat"
to create config file : nano filebeat-configuration.yml (copy paste filebeat config file in nano)
to create playbook : nano  filebeat-playbook.yml (copy paste filebeat playbook file in nano)
to run playbook : ansible-playbook filebeat-playbook

"MetricBeat"
to creat config file : nano metricbeat-configuration.yml (copy paste metricbeat-configuration.yml file)
to create playbook : nano metricbeat-playbook.yml (copy paste metricbeat-playbook.yml file)

to run playbook : ansible-playbook metricbeat-playbook.yml
