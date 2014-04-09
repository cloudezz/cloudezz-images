import os;
import socket;
import json;
import os;
import linecache

from random import randrange
from fabric.api import run, local, cd, env, roles, execute

tmp_filename='/tmp/listen.cfg'
tmp_tmp='/tmp/listen_tmp.cfg'


def file_len(file,lookup):
    line_offset = []
    offset = 0
    linenum =0;
    for line in file:
        line_offset.append(offset)
        offset += len(line)
        linenum = linenum+1;
        if lookup in line:
            return linenum, line_offset[linenum-1];
    return -1,-1

def write_haproxy_tmpfile(member):
    member_ip = member['tags']['host_ip']
    member_role =  member['tags']['role']
    member_exposed_ports = member['tags']['expose_default_host_port'] 
    member_exposed_ports_array = tuple(member_exposed_ports.split(','));
    if(member_exposed_ports_array):
         if os.path.isfile(tmp_filename):
             f = open(tmp_filename, 'r+')
             linenum, offset = file_len(f, '##Stop '+member_role)
             if(linenum<=0):
                 f.seek(0,2);
                 f.write('\n##Start '+member_role);
                 for ports in member_exposed_ports_array:
                     lxc_port,  host_port = ports.split(':');
                     f.write('\nlisten '+member_role+'-'+lxc_port);
                     f.write('\n\tbind *:' + lxc_port)
                     f.write('\n\tmode tcp\n\tbalance roundrobin');
                     f.write('\n\tserver ' + member_role+'-'+str(randrange(10))+ ' '+member_ip+':'+host_port)
                 f.write('\n##Stop '+member_role);
                 f.seek(0);
                 f.close();
             else:
                 #if the file aleady has an entry for '##Stop '+member_role then append it inside the appropriate listen
                 f2 = open(tmp_tmp, 'w')
                 f.seek(0);
                 for line in f:
                     if '##Stop '+member_role not in line:
                         f2.write(line)
                     else:
                         for ports in member_exposed_ports_array:
                             lxc_port,  host_port = ports.split(':');
                             f2.write('\tserver ' + member_role+'-'+str(randrange(10))+ ' '+member_ip+':'+host_port)                      
                         f2.write('\n##Stop '+member_role+"\n");
                 f.close();
                 f2.close();
                 os.remove(tmp_filename)
                 os.rename(tmp_tmp, tmp_filename)
                 f.close();
         else:
             f = open(tmp_filename, 'w')
             f.write('##Start '+member_role);
             for ports in member_exposed_ports_array:
                 lxc_port,  host_port = ports.split(':');
                 f.write('\nlisten '+member_role+'-'+lxc_port);
                 f.write('\n\tbind *:' + lxc_port)
                 f.write('\n\tmode tcp\n\tbalance roundrobin');
                 f.write('\n\tserver ' + member_role+'-'+str(randrange(10))+ ' '+member_ip+':'+host_port)
             f.write('\n##Stop '+member_role);
             f.close();
    
##Main Method
def main():
    serf_members_out = local('serf members -tag is_service=true -status=alive -format=json', capture=True);
    serf_members_json = json.loads(serf_members_out);
    members = serf_members_json['members'];
    if not members:
        local('rm /opt/cloudezz-config/haproxy.cfg', capture=True)
        local('supervisorctl stop haproxy', capture=True );
        return;
    for member in members:
        write_haproxy_tmpfile(member)
    #copy the original base file and the listen file to haproxy cfg file and then restart haproxy
    local('cat /opt/cloudezz-config/haproxy.cfg.base > /opt/cloudezz-config/haproxy.cfg', capture=True);
    local('echo >> /opt/cloudezz-config/haproxy.cfg', capture=True)
    local('echo >> /opt/cloudezz-config/haproxy.cfg', capture=True)
    local('cat /tmp/listen.cfg >> /opt/cloudezz-config/haproxy.cfg', capture=True);
    local('echo >> /opt/cloudezz-config/haproxy.cfg', capture=True)
    local('echo >> /opt/cloudezz-config/haproxy.cfg', capture=True)
    
    local('supervisorctl restart haproxy', capture=True );




# json1 = '{"members": [     {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45954",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    }  ]}';  
# json1 = '{"members": [   {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45954",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    },  {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45954",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    } ,    {      "name": "d344680ad46b",      "addr": "172.17.0.3:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45098",        "expose_default_port": "",        "host_ip": "10.1.1.1",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "failed",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    },{      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "100:900,200:901,300:902",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "rabbitmq",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    }, {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:25954",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    }  ]}';  
# 
# if os.path.isfile(tmp_filename):
#     os.remove(tmp_filename)
# main(json1);

if __name__ =="__main__":
    main();  