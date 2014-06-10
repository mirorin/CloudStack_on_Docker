CloudStack on Docker
--------------------

How to install CloudStack Management Server using Dockerfile.

1. git clone the file to your computer  
    $ git clone https://github.com/mirorin/CloudStack_on_Docker.git

2. Build docker image  
    $ cd \<DIRECTORY\>    
    $ sudo docker build -t \<REPOSITORY NAME\>/\<TAG NAME\> .

3. Run docker container from created image  
    $ sudo docker run --privileged -d -p 22 -p 3306 -p 8080 -h \<SERVERNAME\>.\<DOMAIN\> --name="management-server" \<REPOSITORY NAME\>/\<TAG NAME\> /usr/bin/supervisord

4. Confirm mapped-port  
    $ sudo docker ps -a

5. Login to the container via ssh  
    $ ssh root@\<DOCKER 0 IP\> -p \<PORT\>

6. Setup Management Server  
    \# cloudstack-setup-databases cloud:\<PASSWORD\>@localhost --deploy-as=root:\<PASSWORD\>  
    \# cloudstack-setup-management

