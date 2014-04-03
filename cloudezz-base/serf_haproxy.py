import os;
import socket;
import json;
import os;
import linecache

from random import randrange

# from fabric.api import run, local, cd, env, roles, execute

tmp_filename='listen.cfg'

def file_len(filename, lookup):
    line_offset = []
    offset = 0
    with open(filename) as myFile:
        for num, line in enumerate(myFile, 1):
            line_offset.append(offset)
            offset += len(line.expandtabs())
            if lookup in line:
                print num, line_offset
                return num, line_offset[num-1]
    return -1,-1
            
def main(json_inp):
#     serf_members_out = local('serf members -tag is_service=true -status=alive -format=json');
    serf_members_json = json.loads(json_inp);
    members = serf_members_json['members'];
    for member in members:
        is_service = member['tags']['is_service']
        if is_service == "false":
            member_ip = member['tags']['host_ip']
            member_role =  member['tags']['role']
            member_exposed_ports = member['tags']['expose_default_host_port'] 
            print member_exposed_ports
            member_exposed_ports_array = tuple(member_exposed_ports.split(','));
            if(member_exposed_ports_array):
                 if os.path.isfile(tmp_filename):
                     f = open(tmp_filename, 'r+')
                     linenum, offset = file_len(tmp_filename, '##Stop '+member_role)
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
                         f.close();
                     else:
                         old = f.read();
                         f.seek(0,0);
                         f.write(old);
                         f.seek(0-len('\n##Stop '+member_role)-1,1)
                         for ports in member_exposed_ports_array:
                             lxc_port,  host_port = ports.split(':');
                             f.write('\n\tserver ' + member_role+'-'+str(randrange(10))+ ' '+member_ip+':'+host_port)
                         f.write('\n##Stop '+member_role);
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

# json1 = '{"members": [     {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45954",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    }  ]}';  
json1 = '{"members": [   {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45954",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    },  {      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:49154",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    } ,    {      "name": "d344680ad46b",      "addr": "172.17.0.3:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "3306:45098",        "expose_default_port": "",        "host_ip": "10.1.1.1",        "is_service": "false",        "role": "mysql",        "serf_host_port": ""      },      "status": "failed",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    },{      "name": "db4c20f0ac53",      "addr": "172.17.0.2:7946",      "port": 7946,      "tags": {        "cluster_id": "",        "expose_default_host_port": "100:900,200:901,300:902",        "expose_default_port": "",        "host_ip": "10.0.2.2",        "is_service": "false",        "role": "rabbitmq",        "serf_host_port": ""      },      "status": "alive",      "protocol": {        "max": 4,        "min": 2,        "version": 4      }    } ]}';  

if os.path.isfile(tmp_filename):
    os.remove(tmp_filename)
main(json1);