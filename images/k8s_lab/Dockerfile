FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y socat && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs vim build-essential apt-transport-https ca-certificates curl gnupg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
    chmod 644 /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl && \
    useradd labuser -m -s /bin/bash

# Create and set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Switch to non-root user
USER labuser

# Set the prompt
RUN echo "PS1='\${debian_chroot:+(\$debian_chroot)}\\[\033[01;32m\\]\\u@lab\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '" >> ~/.bashrc && \
    echo "cd /home/labuser" >> ~/.bashrc
# Expose the port the app runs ons
EXPOSE 8080
EXPOSE 6060

# Command to run both backend.js and app.js
CMD ["sh", "-c", "npm start"]

