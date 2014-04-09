import requests;
import os;
import socket;

from fabric.api import run, local, cd, env, roles, execute


def joinSerf(leader):
    #HOW DO WE GET THE IP TO JOIN
    local('serf join ' + leader.ip+':'+l)

def main ():
    r = requests.get('http://10.0.2.2:8090/app/rest/clusterconfigs');
    if(r.status_code == 200):
        json = r.json();
        print json;
        if json:
            leader = json[0];
            joinSerf(leader);
        else:
            r = requests.post('http://10.0.2.2:8090/app/rest/clusterconfigs', 
                              {"clusterKey": os.environ['SERF_CLUSTER_KEY'], "nodeName" : os.environ['SERF_NODE_NAME'],
                               "port" : os.environ['DEFAULT_PORT_TO_EXPOSE'], "ip":os.environ['HOST_IP']});
            if(r.status_code == 200):
                leader = r.json();
                print "Created Leader";
                print leader;
                
                
                          
          
if __name__ =="__main__":
    main();                          
        
        
         
