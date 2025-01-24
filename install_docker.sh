# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl 
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \ 
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null # Add the Docker repository to the sources list
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin   # Install Docker
sudo systemctl start docker # Start Docker
sudo systemctl enable docker # Start Docker on boot
sudo usermod -aG docker $USER # Add the current user to the Docker group
newgrp docker # Activate the changes to groups
docker --version # Check Docker version
sudo docker run hello-world # Test Docker installation