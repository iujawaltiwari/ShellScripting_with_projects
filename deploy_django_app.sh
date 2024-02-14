#!/bin/bash

<< task
Deploy a Django app
and handle the code for erros
task

code_clone() {

      echo "Cloning the django app..."
      git clone https://github.com/LondheShubham153/django-notes-app.git

}

install_requirements() {
   
	echo "Installing dependencies"
	sudo apt-get install docker.io nginx -y


}

required_restarts() {

	 sudo chown $USER /var/run/docker.sock
         sudo systemctl enable docker
	 sudo systemctl enable nginx
	 sudo systemctl restart docker
}

deploy() {

     docker build -t notes-app .
     docker run -d -p 8000:8000 notes-app:latest
}

echo "************ DEPLOYMENT STARTED ***************************"

if ! code_clone; then
	echo "The Code Directory already exist"
	cd django-notes-app
fi
if ! install_requirements; then
	echo "Installation failed"
	exit 1
fi
if ! required_restarts; then
	echo "System fault Identified"
	exit 1
fi
deploy


echo "************ DEPLOYMENT DONE ***************************"
