#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./start.sh <container name>"
    exit
fi

source .env
if [ -z "$ELASTICSEARCH_PASSWORD" ]; then
    echo 'Please input your elastic password like "export ELASTICSEARCH_PASSWORD=<PASSWORD>"'
    exit 1
fi

CONTAINER_NAME=$1

if [ ! -d "$PWD/$1" ]; then
    cp -r $PWD/conf/logstash $PWD/$1
else
    echo "'$1' already exists"
    exit 1
fi

sed -i "s#\$ELASTICSEARCH_HOST#$ELASTICSEARCH_HOST#g" $PWD/$1/config/logstash.yml
sed -i "s/\$ELASTICSEARCH_PASSWORD/$ELASTICSEARCH_PASSWORD/g" $PWD/$1/config/logstash.yml
sed -i "s#\$OUTPUT_ELASTICSEARCH_HOST#$OUTPUT_ELASTICSEARCH_HOST#g" $PWD/$1/pipeline/logstash.conf
sed -i "s/\$ELASTICSEARCH_PASSWORD/$ELASTICSEARCH_PASSWORD/g" $PWD/$1/pipeline/logstash.conf
sed -i "s/\$CONTAINER_NAME/$CONTAINER_NAME/g" $PWD/$1/docker-compose.yml
sed -i "s/\$LOGSTASH_VERSION/$LOGSTASH_VERSION/g" $PWD/$1/docker-compose.yml

cd $1
docker-compose up --build --detach
cd ..