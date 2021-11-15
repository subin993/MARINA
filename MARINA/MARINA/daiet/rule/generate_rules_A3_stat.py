#!/usr/bin/python


import fileinput
import os

rule_file = open('/home/mnc/p4-dev/topk/daiet/rule/rule_file.txt', 'r+')
data = rule_file.read()

port_mapping = {}
port_mapping['edge1'] = 0
port_mapping['edge2'] = 0
port_mapping['edge3'] = 2
port_mapping['edge4'] = 2
port_mapping['edge5'] = 0
port_mapping['edge6'] = 2
port_mapping['edge7'] = 0
port_mapping['edge8'] = 4

port_mapping['aggr1'] = 0
port_mapping['aggr2'] = 0
port_mapping['aggr3'] = 0
port_mapping['aggr4'] = 1
port_mapping['aggr5'] = 0
port_mapping['aggr6'] = 1
port_mapping['aggr7'] = 0
port_mapping['aggr8'] = 4

port_mapping['core1'] = 0
port_mapping['core2'] = 0
port_mapping['core3'] = 4
port_mapping['core4'] = 0

set_child = {}
set_child['edge1'] = 0
set_child['edge2'] = 0
set_child['edge3'] = 1
set_child['edge4'] = 1
set_child['edge5'] = 0
set_child['edge6'] = 1
set_child['edge7'] = 0
set_child['edge8'] = 3

set_child['aggr1'] = 0
set_child['aggr2'] = 0
set_child['aggr3'] = 0
set_child['aggr4'] = 2
set_child['aggr5'] = 0
set_child['aggr6'] = 1
set_child['aggr7'] = 0
set_child['aggr8'] = 3

set_child['core1'] = 0
set_child['core2'] = 0
set_child['core3'] = 3
set_child['core4'] = 0

print(str(port_mapping['edge%s' %str(1)])) 

for i in range(8):
    i=i+1
    
    rule_file = open('/home/mnc/p4-dev/topk/daiet/rule/rule_file.txt', 'r+')
    dest_file = open('/home/mnc/p4-dev/topk/daiet/rule/edge/edge%s' %str(i), 'w+')

    for line in rule_file:
        line = line.replace("XX", str(port_mapping['edge%s' %str(i)])) 
        line = line.replace("YY", str(set_child['edge%s' %str(i)])) 
        dest_file.write(line)
    dest_file.close()

for i in range(8):
    i=i+1

    rule_file = open('/home/mnc/p4-dev/topk/daiet/rule/rule_file.txt', 'r+')
    dest_file = open('/home/mnc/p4-dev/topk/daiet/rule/aggr/aggr%s' %str(i), 'w+')

    for line in rule_file:
        line = line.replace("XX", str(port_mapping['aggr%s' %str(i)])) 
        line = line.replace("YY", str(set_child['aggr%s' %str(i)])) 
        dest_file.write(line)
    dest_file.close()

for i in range(4):
    i=i+1

    rule_file = open('/home/mnc/p4-dev/topk/daiet/rule/rule_file.txt', 'r+')
    dest_file = open('/home/mnc/p4-dev/topk/daiet/rule/core/core%s' %str(i), 'w+')
    
    for line in rule_file:
        line = line.replace("XX", str(port_mapping['core%s' %str(i)])) 
        line = line.replace("YY", str(set_child['core%s' %str(i)])) 
        dest_file.write(line)
    dest_file.close()

rule_file.close()