#!/bin/bash

wait-for-it.sh zookeeper:2181 -t 40
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e " Apache ZooKeeper not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start kafka

rm /opt/kafka-manager/RUNNING_PID 2>/dev/null

supervisorctl start kafka-manager

wait-for-it.sh localhost:9000 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Kafka Manager not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

ip=`awk 'END{print $1}' /etc/hosts`

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the Kafka Manager url:\n"
echo -e "	http://$ip:9000"
echo -e "\nMantainer:   Matteo Capitanio <matteo.capitanio@gmail.com>"
echo -e "--------------------------------------------------------------------------------\n\n"




