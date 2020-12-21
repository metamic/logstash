# logstash
logstash for quick starter

## Usage
in your terminal
```
chmod 755 ./start.sh
export ELASTICSEARCH_PASSWORD=<YOUR PASSWORD>
./start.sh <CONAINER_NAME>
```

set your monitoring elasticsearch host and output elasticsearch host in .env file
```
LOGSTASH_VERSION=7.10.1
ELASTICSEARCH_HOST=http://172.17.0.1:9200       <<< here
OUTPUT_ELASTICSEARCH_HOST=172.17.0.1:9200       <<< here
# ELASTICSEARCH_PASSWORD=<YOUR_PASSWORD>
```

when you want to reset elasticsearch container, remove created folder and remove docker
```
rm -r <CONTAINER_NAME_FOLDER>
docker stop <CONTAINER_NAME>
docker rm <CONTAINER_NAME>
```