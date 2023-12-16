# docker-systemd

## Description
This is a basic Ubuntu 22.04 container, running systemd internally.  It was originally created to allow college students to have their own (private) Docker environments in a Guacamole-based environment (i.e., not your usual Docker-in-Docker usage).  If you want to use the image for something other than Docker and OpenVirtualSwitch (OVS):
* edit the Dockerfile and remove the mentions of Docker and OVS
* edit the build-image script and change "did" to something better for your image name
* edit the build-container script and change both instances of "did" to something better (the second "did" must match your image name)

I've also included two short Bash scripts, one to build the image and one to create a container from that image.
