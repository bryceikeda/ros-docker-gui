FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

MAINTAINER Athanasios Tasoglou <athanasios@tasoglou.net>
LABEL Description="ROS: Noetic-Desktop (Ubuntu 20.04)" Vendor="TurluCode" Version="1.2"
LABEL com.turlucode.ros.version="noetic"

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN apt-get update && apt-get install -y \
locales \
lsb-release \
mesa-utils \
git \
subversion \
vim \
terminator \
xterm \
wget \
curl \
htop \
libssl-dev \
build-essential \
dbus-x11 \
software-properties-common \
gdb valgrind && \
apt-get clean && rm -rf /var/lib/apt/lists/*

# Install ROS
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    ros-noetic-desktop-full python3-catkin-tools python3-rosdep \
    python3-rosinstall-generator python3-vcstool build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install cmake 3.26.3
RUN git clone https://gitlab.kitware.com/cmake/cmake.git && \
    cd cmake && git checkout tags/v3.26.3 && ./bootstrap --parallel=8 && make -j8 && make install && \
    cd .. && rm -rf cmake

# Install required Python packages and set up locale
RUN apt-get update && apt-get install -y python3-pip python3 build-essential && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip3 install --upgrade pip virtualenv paramiko numpy protobuf ruff && \
    locale-gen en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LANGUAGE=en_US:en && \
    export LC_ALL=en_US.UTF-8

# Configure Terminator
RUN mkdir -p /root/.config/terminator/
COPY assets/terminator_config /root/.config/terminator/config
COPY assets/terminator_background.png /root/.config/terminator/background.png

# Install OhMyZSH
RUN apt-get update && apt-get install -y zsh && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s /usr/bin/zsh root
RUN git clone https://github.com/bryceikeda/sky.git /root/.oh-my-zsh/custom/sky
RUN cp /root/.oh-my-zsh/custom/sky/.profile /root/
RUN ln -s /root/.oh-my-zsh/custom/sky/sky.zsh-theme /root/.oh-my-zsh/custom/
RUN ln -s /root/.oh-my-zsh/custom/sky/sky-hostname.zsh-theme /root/.oh-my-zsh/custom/
RUN sed -i -e 's/ZSH_THEME="robbyrussell"/[[ -n $SSH_CONNECTION ]] \&\& ZSH_THEME="sky-hostname" || ZSH_THEME="sky"/' /root/.zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN sed -i '/plugins=(git)/c\plugins=(git pyenv colored-man-pages command-not-found extract z zsh-autosuggestions)' /root/.zshrc

# Install VS Code
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update && apt-get install -y code && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure ROS environment
RUN rosdep init && rosdep update && \
    echo 'DISABLE_AUTO_UPDATE="true"' >> /root/.zshrc && \
    echo 'ENABLE_CORRECTION="false"' >> /root/.zshrc && \
    echo 'HYPHEN_INSENSITIVE="true"' >> /root/.zshrc && \
    echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc && \
    echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.bashrc && \
    echo "source /opt/ros/noetic/setup.zsh" >> /root/.zshrc && \
    echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.zshrc

# Entry script
COPY assets/entrypoint_setup.sh /
ENTRYPOINT ["/entrypoint_setup.sh"]

# Launch terminator
CMD ["terminator"]
