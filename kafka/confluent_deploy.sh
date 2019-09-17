#/bin/bash

# Install incubator
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

# Install kafka and zookeeper
helm install --name my-kafka --namespace kafka incubator/kafka --set external.enabled=true

# Install stable repository
helm repo add helmstable https://kubernetes-charts.storage.googleapis.com/

# start kafka connect
docker run -it --rm --name connect -p 8083:8083 -e GROUP_ID=1 -e CONFIG_STORAGE_TOPIC=my_connect_configs -e OFFSET_STORAGE_TOPIC=my_connect_offsets -e STATUS_STORAGE_TOPIC=my_connect_statuses --link zookeeper:zookeeper --link kafka:kafka --link mysql:mysql debezium/connect:0.9

docker run --net=host --rm  confluentinc/cp-kafka:3.0.0 kafka-topics --create --topic quickstart-avro-offsets --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181

# install the schema registry
# documentation url https://github.com/helm/charts/tree/master/incubator/schema-registry
helm install --name my-schema-registry --namespace kafka --set kafka.enabled=false,external.enabled=true,external.type=NodePort,kafkaStore.overrideBootstrapServers=PLAINTEXT://my-kafka:9092 incubator/schema-registry

# install the rest api
helm install --name my-kafka-rest --namespace kafka --set external.enabled=true,external.type=NodePort,cp-zookeeper.url="my-kafka-zookeeper:2181",cp-schema-registry.url="my-schema-registry:8081" charts/cp-kafka-rest