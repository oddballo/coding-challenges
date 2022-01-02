#!/bin/bash

# If docker-ce isn't installed, assume fresh installation
apt -qq list docker-ce 2>/dev/null | grep -q installed
if [ $? -ne 0 ]; then
	sudo apt-get -y remove docker docker.io containerd runc \
		&& sudo apt-get update \
		&& sudo apt-get -y install \
			    ca-certificates \
			    curl \
			    gnupg \
			    lsb-release \
		&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
			sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
	  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
		&& sudo apt-get update \
		&& sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
		|| { echo "There was a problem installing. Aborting."; exit 1; }
fi

# Configure Docker systemd to expose Docker over network
# NOTE: assuming VM/instance is not public facing and opening to all addresses
sudo mkdir -p /etc/docker/
sudo tee <<"EOF" /etc/docker/daemon.json
{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee <<"EOF" /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker.service

# Add local user to Docker group
sudo usermod -a -G docker "$(id --user --name)"
