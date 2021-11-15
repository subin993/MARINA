#!/bin/bash

for i in `seq 1 10`
do
type='daiet'
dist='g'

    for j in 50 100 150 200 250 300 350 400 450 500
    do
        num=$j
        echo $j
        sleep=`expr $j / 10`

        screen -S mininet$i -d -m -L sudo bash /home/mnc/p4-dev/topk/topology/run_topo_daiet.sh && sleep 8
        nohup sudo python /home/mnc/p4-dev/topk/packets/receive.py --i edge8-eth4 --s 0 --save_index $num'-'$i'-'$dist --type $type &
        sudo bash /home/mnc/p4-dev/topk/daiet/insert_rule_daiet.sh && sleep 2
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge1-eth3 --si '10.0.0.1' --dist $dist --num_flush 0 --num $num --dif '10.0.1.1' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge1-eth4 --si '10.0.0.2' --dist $dist --num_flush 0 --num $num --dif '10.0.2.1' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge2-eth3 --si '10.0.0.3' --dist $dist --num_flush 0 --num $num --dif '10.0.1.2' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge2-eth4 --si '10.0.0.4' --dist $dist --num_flush 0 --num $num --dif '10.0.3.1' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge3-eth3 --si '10.0.0.5' --dist $dist --num_flush 0 --num $num --dif '10.0.1.3' & sleep 1
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge3-eth4 --si '10.0.0.6' --dist $dist --num_flush 0 --num $num --dif '10.0.2.3' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge4-eth3 --si '10.0.0.7' --dist $dist --num_flush 0 --num $num --dif '10.0.1.4' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge4-eth4 --si '10.0.0.8' --dist $dist --num_flush 0 --num $num --dif '10.0.3.2' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge5-eth3 --si '10.0.0.9' --dist $dist --num_flush 0 --num $num --dif '10.0.1.5' & 
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge5-eth4 --si '10.0.0.10' --dist $dist --num_flush 0 --num $num --dif '10.0.2.6' &
        nohup sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge6-eth3 --si '10.0.0.11' --dist $dist --num_flush 0 --num $num --dif '10.0.1.6' &
        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge6-eth4 --si '10.0.0.12' --dist $dist --num_flush 0 --num $num --dif '10.0.3.4' && sleep 20

        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge1-eth3 --si '10.0.0.1'  --num_flush 1 --daiet 1 --dif '10.0.1.1' && sleep 2
        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge2-eth3 --si '10.0.0.3'  --num_flush 1 --daiet 1 --dif '10.0.1.2' && sleep 2
        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge3-eth3 --si '10.0.0.5'  --num_flush 1 --daiet 1 --dif '10.0.1.3' && sleep 2
        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge4-eth3 --si '10.0.0.7'  --num_flush 1 --daiet 1 --dif '10.0.1.4' && sleep 2
        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge5-eth3 --si '10.0.0.9'  --num_flush 1 --daiet 1 --dif '10.0.1.5' && sleep 2
        sudo python /home/mnc/p4-dev/topk/packets/send.py --i edge6-eth3 --si '10.0.0.11' --num_flush 1 --daiet 1 --dif '10.0.1.6' && sleep $sleep
        sudo kill -9 `ps -ef | grep receive.py | grep save_index | awk '{print $2}' ` && sleep 1
        sudo kill -9 `ps -ef | grep send.py | grep nohup | awk '{print $2}' ` && sleep 1
        screen -X -S mininet$i quit && sleep 2
        sudo mn -c 
    done
done