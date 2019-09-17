# Kafka Connect Notes
Just some notes on setting up kafka connect

### Step 1: clone down this repository



### Step 2: Find the connectors you want to include on the Confluent website
https://docs.confluent.io/current/connect/managing/connectors.html

### Step 3: Download the connector JAR files
Example: download the mysql zip and extract the jar file (select platform independent)
https://dev.mysql.com/downloads/connector/j/ 

### Step 4: Copy the jar file into the "connectors" folder
Put your connectors here, and modify the dockerfile to copy the files where they should go inside of conenct when the dockerfile is built.  Example shown in the Dockerfile is for mysql, which is jdbc based.

### Step 5: Build and push the dockerfile
```
docker build . -t "michaelsteven/kafka-connect-mysql:latest"
```
```
docker push  michaelsteven/kafka-connect-mysql:latest
```

### Step 6: Deploy  the helm chart
```
helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts/
```
```
helm repo update
```
```
helm install --name my-kafka-connect --namespace kafka --set external.enabled=true,external.type=NodePort,image=michaelsteven/kafka-connect-mysql,imageTag=latest,kafka.bootstrapServers="PLAINTEXT://my-kafka:9092",cp-schema-registry.url="my-schema-registry:8081" charts/kafka-connect-mysql
```

### Step 7: Post in a connector configuration using postgres using the Kafka Connect API
- example POST url for postman: http://localhost:31387/connectors

- payload:
```
{
  "name": "mike-test1",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "tasks.max": "1",
    "topics": "test1",
    "connection.url": "jdbc:mysql://opencart-mariadb.opencart:3306/bitnami_opencart",
    "connection.user": "bn_opencart",
    "connection.password": "Kdz3V99pWH",
    "mode": "incrementing",
    "incrementing.column.name": "rollno",
    "topic.prefix": "test1-",
    "table.whitelist": "actor"
  }
}
```



