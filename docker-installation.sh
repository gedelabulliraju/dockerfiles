#!/bin/bash
USERID=$(id -u)
#echo "User ID is: $USERID"
if [ $USERID -ne 0 ]
then
    echo "Please run this script with root privileges"
    exit 1
fi
#Add docker reposirory to config-manager 
dnf -y install dnf-plugins-core
if [ $? -ne 0 ]
then
    echo "Failed to install dnf-plugins-core, please check the logs."
    exit 1
else
    echo "dnf-plugins-core installed successfully."
fi
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
if [ $? -ne 0 ]
then
    echo "Failed to add Docker repository, please check the logs."
    exit 1
else
    echo "Docker repository added successfully."
fi
#Install docker dependencies
#Install using the rpm repository
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
if [ $? -ne 0 ]
then
    echo "Docker installation failed, please check the logs."
    exit 1
else
    echo "Docker installation is successful."
fi
#add ec2-user to docker group
usermod -aG docker ec2-user
if [ $? -ne 0 ]
then
    echo "Failed to add user to docker group, please check the logs."
    exit 1
else
    echo "User added to docker group successfully."
fi
#Start docker service
systemctl start docker
if [ $? -ne 0 ]
then
    echo "Failed to start docker service, please check the logs."
    exit 1
else
    echo "Docker service started successfully."
fi
#Enable docker service to start on boot
systemctl enable docker
if [ $? -ne 0 ]
then
    echo "Failed to enable docker service on boot, please check the logs."
    exit 1
else
    echo "Docker service enabled to start on boot successfully."
fi
#Check docker version
docker --version
if [ $? -ne 0 ]             
then
    echo "Docker is not installed correctly, please check the logs."
    exit 1
else
    echo "Docker is installed and running successfully."
fi
systemctl restart deamon
if [ $? -ne 0 ]
then
    echo "Failed to restart daemon, please check the logs."
    exit 1
else
    echo "Daemon restarted successfully."
fi
echo "Docker installation and configuration completed successfully."
echo "You can now use Docker commands without sudo."
echo "Please log out and log back in to apply the group changes."
echo "Thank you for using this script." 