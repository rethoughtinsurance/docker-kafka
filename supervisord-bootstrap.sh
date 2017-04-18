#!/bin/bash

./wait-for-it.sh zookeeper:2181 -t 40
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e " Apache ZooKeeper not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start kafka

./wait-for-it.sh localhost:9092 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Kafka not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start kafka-rest

./wait-for-it.sh localhost:8082 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Kafka REST not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start schema-registry

./wait-for-it.sh localhost:8081 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Schema Registry not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start kafka-topics-ui

./wait-for-it.sh localhost:8000 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e " Kafka Topics UI not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the Kafka Manager url:\n"
echo -e "\tKafka REST:         http://localhost:8082"
echo -e "\tSchema Registry:    http://localhost:8081"
echo -e "\tKafka Topics UI:    http://localhost:8000"
echo -e "\nMantainer:   Matteo Capitanio <matteo.capitanio@gmail.com>"
echo -e "--------------------------------------------------------------------------------\n\n"



