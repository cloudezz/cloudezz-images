tomcat7-docker
==============

Tomcat 7 image with easy war deploy from command line arg 

Usage 
 test.war" 

docker run -i -t -p 8080:8080 -e WAR_URL="http://web-actions.googlecode.com/files/helloworld.war"  bbytes/tomcat7

The command will remove all war files in webapps and add the war file given in arg 1 
