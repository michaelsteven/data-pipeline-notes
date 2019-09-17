FROM confluentinc/cp-kafka-connect:5.3.1

COPY connectors/mysql-connector-java-8.0.17.jar /usr/share/java/kafka-connect-jdbc/

USER root:root
RUN addgroup --gid 5000 --system esgroup && \
    adduser --uid 5000 --ingroup esgroup --system esuser

USER esuser

