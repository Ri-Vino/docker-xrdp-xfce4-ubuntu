# Dockerized Ubuntu with XFCE, XRDP, and Development Tools

This Docker image sets up an Ubuntu-based environment with XFCE as the desktop environment, XRDP for remote desktop access, and a variety of development tools. It is ideal for users who want a lightweight, customizable Linux desktop environment in a container, ready for remote access and development tasks.

## Features

- **Ubuntu Base**: Latest Ubuntu image
- **XFCE Desktop**: Lightweight desktop environment
- **XRDP**: Remote desktop access
- **Development Tools**: Includes a wide range of development utilities such as:
  - Editors: Vim, Gedit, Kate
  - Compilers: GCC, G++
  - Python: Python 3 and pip
  - Version Control: Git
  - C++: Build essentials
  - IDEs: Qt Creator
  - Other utilities: curl, wget, htop, etc.
- **Powerlevel10k Theme**: Zsh with Powerlevel10k theme and useful plugins like `zsh-autosuggestions` and `zsh-syntax-highlighting`
- **Applications**: Firefox, Thunderbird, LibreOffice, VLC, GIMP, and more

## How to Use

1. **Install Docker Desktop**:
   Before using this Docker image, you need to have Docker installed on your machine. Download and install Docker Desktop from the official Docker website:  
   [Docker Desktop Download](https://www.docker.com/products/docker-desktop)

2. **Build the Docker Image**:
   Once Docker Desktop is installed, open a terminal and navigate to the directory where the `Dockerfile` is located. Then, run the following command to build the Docker image:

   ```bash
   docker build -t ubuntu-xfce-xrdp .
   ```
   
3. **Run the Container**: After building the image, you can run the container with the following command:
   ```bash
   docker run -d -p 3389:3389 --name xfce-xrdp ubuntu-xfce-xrdp
   ```
This will run the container in the background, exposing port 3389 for remote desktop access.

4. **Access the Container via XRDP**: Use an XRDP-compatible client (such as Remote Desktop Connection on Windows) to connect to localhost:3389. Log in with the username "username" and the password "password" (or change the credentials as needed).

5. **Customize the Environment**: You can edit the Dockerfile or add additional applications as needed. The container is designed to be flexible and easy to extend.

## Notes

- The Dockerfile installs a large number of applications. If you need a more minimal environment, you can modify the `Dockerfile` to remove any unnecessary packages.
- This environment is designed for remote access. You can access your development tools and desktop applications remotely via XRDP.

## PS:
note that the audio doesn't work on the containers
