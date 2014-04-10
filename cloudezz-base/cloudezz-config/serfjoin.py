import requests;
import os;
import socket;

from fabric.api import run, local, cd, env, roles, execute


def joinSerf(leader):
    print "Joining the cluster"
    local('serf join ' + leader.ip+':'+leader.port)

def main ():
    base_url = os.environ['HOUSTON_PROTOCOL']+"://"+os.environ['HOUSTON_HOST_IP']+":"+os.environ['HOUSTON_PORT'];
    
    r = requests.get(base_url+'/app/rest/clusterconfigs');
    if(r.status_code == 200):
        json = r.json();
        print json;
        if json:
            leader = json[0];
            joinSerf(leader);
        else:
            r = requests.post(base_url+'/app/rest/clusterconfigs', 
                              {"clusterKey": os.environ['SERF_CLUSTER_KEY'], "nodeName" : os.environ['SERF_NODE_NAME'],
                               "port" : os.environ['DEFAULT_PORT_TO_EXPOSE'], "ip":os.environ['HOST_IP']});
            if(r.status_code == 200):
                leader = r.json();
                print "Created Leader";
                print leader;
                
                
                          
          
if __name__ =="__main__":
    main();                          
        
        
         
