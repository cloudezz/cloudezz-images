
### To run:

    sudo docker pull cloudezz/rabbitmq
    sudo docker run -p :5672 -p :15672 cloudezz/rabbitmq
	
	or
	
	sudo docker run -e RABBITMQ_USER=admin RABBITMQ_PASSWORD=adminpassword -p :5672 -p :15672 cloudezz/rabbitmq
	
    
### To persist with vol mapping:



Since RabbitMQ uses the ``$HOSTNAME`` in its data path, we need to explicitly set it for the container.

    $ sudo docker run -h rabbithost -p :5672 -p :15672 -v /tmp/rabbitmq/mnesia:/var/lib/rabbitmq/mnesia cloudezz/rabbitmq
    WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
    
                  RabbitMQ 3.1.5. Copyright (C) 2007-2013 GoPivotal, Inc.
      ##  ##      Licensed under the MPL.  See http://www.rabbitmq.com/
      ##  ##
      ##########  Logs: /var/log/rabbitmq/rabbit@rabbithost.log
      ######  ##        /var/log/rabbitmq/rabbit@rabbithost-sasl.log
      ##########
                  Starting broker... completed with 6 plugins.
