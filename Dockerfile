From ubuntu:22.04
Maintainer Tim Kramer <joatblog@gmail.com>

# Date: 15 Dec 2023

# systemd portion adapted from:
# https://github.com/j8r/dockerfiles/blob/master/systemd/ubuntu/22.04.Dockerfile

# This file was originally created to allow students to have their
# own Docker architectures in a classroom environment.  If you want to
# use it for other things, you may want to remove docker and 
# openvirtualswitch in the below.

# Environment variables
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# modify the following to force apt-get update
RUN touch /tmp/shim-20231215

# update image to most recent binaries
RUN apt-get update && apt-get upgrade -y

# install systemd
RUN apt-get install -y systemd systemd-sysv

# Clean up the systemd install
RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && rm $(ls | grep -v systemd-tmpfiles-setup)
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

# Install dependencies for whatever you're containerizing
RUN apt-get install -y \
    bash \
    curl \
    docker.io \
    net-tools \
    openvswitch-switch \
    vim \
    wget 

# Run your config mods here (e.g., sed, awk, other)

# enable the various services
RUN systemctl enable docker
RUN systemctl enable openvswitch-switch

# cleanup (to make the image smaller)
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set the default folder (when connecting to the container)
WORKDIR /root

# start systemd when the container deploys/starts
CMD ["/lib/systemd/systemd"]
