Node-Docker For Cloudezz 
========================

To run the image with git url 

Interactive mode:

		docker run -i -t -p 3000:3000 -e gitUrl="https://github.com/dhanush/hour-glass.git" bbytes/node
		
		
Daemon mode:

		docker run -d -t -p 3000:3000 -e gitUrl="https://github.com/dhanush/hour-glass.git" bbytes/node
