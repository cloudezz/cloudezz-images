docker-base
===========

The base image with localhost tpc forward option using rinetd tool

Based on ubuntu 12.04 LTS

Supervisord is a linux process manager . It allows us to start containers with e.g.

    multiple processes
    a deamon / background process
    launch groups of processes in a specific order
    

We have port mapping feature too . For eg start the docker image with 

    docker run -i -t -e TCP_FORWARD="127.0.0.1 80 74.125.224.72 80" bbytes/base  supervisord -n -c /etc/supervisor.conf

This will start the image and port mapping bash file will be executes , this adds a port forwarding rule saying any request to 127.0.0.1:80 will go to 74.125.224.72:80 . This might be useful for inter container communication . 

Another Usage for multiple mappings : 

We separate using comma like the one given below 

    docker run -i -t -e TCP_FORWARD="127.0.0.1 80 74.125.224.72 80,127.0.0.1 8090 74.125.224.72 8001" bbytes/base supervisord -n -c /etc/supervisor.conf



To make easy use of supervisord, an inheriting Docker project should contain a file [SOME_NAME].conf and add that to /etc/supervisor/conf.d in the Dockerfile. Note that you can find examples of such files in this repositories projects.

Always start the instance by running CMD cd /opt && ./start.sh



