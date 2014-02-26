Cloudezz tomcat7 image
======================

Tomcat 7 image with easy war deploy from instance arg or git url from arg

Usage 

    docker run -i -t -p 8080:8080 -e warURL="http://web-actions.googlecode.com/files/helloworld.war"  cloudezz/tomcat7
    
or 
    
     docker run -i -t -p 8080:8080 -e gitURL="https://github.com/dhanush/tomcat-demo.git"  cloudezz/tomcat7

The command will remove all war files in webapps and add the war file given in arg 1 
