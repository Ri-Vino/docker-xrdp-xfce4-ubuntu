# Use Ubuntu as the base image
FROM ubuntu:latest

# Update and install XFCE, XRDP, PulseAudio, and necessary applications
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    xfce4 xfce4-goodies xrdp dbus-x11 pulseaudio pavucontrol \
    net-tools iputils-ping htop curl wget sudo \
    nautilus gedit kate vim terminator \
    git g++ make libboost-test-dev build-essential \
    python3 python3-pip qt6-tools-dev qtcreator \
    thunderbird libreoffice \
    vlc gimp \
    zsh dos2unix xxd ssh-askpass locales software-properties-common \
    fonts-powerline  # For Powerlevel10k support

# Set up locales for English UK
RUN locale-gen en_GB.UTF-8 && \
    update-locale LANG=en_GB.UTF-8 LANGUAGE=en_GB:en

# Remove any reboot-required files to prevent conflicts
RUN rm -f /run/reboot-required*

# Add Mozilla PPA to install Firefox as a .deb package
RUN add-apt-repository -y ppa:mozillateam/ppa && \
    echo 'Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001' | tee /etc/apt/preferences.d/mozilla-firefox && \
    apt update && apt install -y firefox

# Create a user with sudo privileges and set up their home directory
RUN useradd -m username -s $(which zsh) -p $(openssl passwd -1 password) && \
    usermod -aG sudo username

# Install Oh My Zsh and Powerlevel10k theme
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Install additional Zsh plugins for better user experience
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc

# Configure XRDP to start XFCE
RUN adduser xrdp ssl-cert && \
    echo "xfce4-session" > /home/username/.xsession && \
    chown username:username /home/username/.xsession

# Set Zsh as the default shell for the new user
RUN chsh -s $(which zsh) username

# Expose the XRDP port for remote access
EXPOSE 3389

# Copy and set permissions for start-up script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set start.sh as the entrypoint
ENTRYPOINT ["/start.sh"]
