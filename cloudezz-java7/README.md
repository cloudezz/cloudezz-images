tomcat7-docker
==============

Tomcat 7 image with easy war deploy from command line arg 

Usage 
 
     docker run -i -t -p 8080:8080 -e warURL="http://web-actions.googlecode.com/files/helloworld.war"  cloudezz/tomcat7

or 

     docker run -i -t -p 8080:8080 -e gitUrl="https://github.com/dhanush/hour-glass.git" cloudezz/tomcat7

The command will remove all war files in webapps and add the war file given in arg 1 
