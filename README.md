# **kafka**
___

### Description


This image runs:

 * the Confluent distribution of [*Apache Kafka*](https://github.com/confluentinc/kafka.git)
 * the Confluent [*Kafka REST Proxy*](https://github.com/confluentinc/kafka-rest.git)
 * the Confluent [*Schema Registry*](https://github.com/confluentinc/schema-registry.git)
 * [*Kafka Topics UI*](https://github.com/Landoop/kafka-topics-ui.git)
 
on a Centos Linux distribution.

The *latest* tag of this image is build with the [latest stable](https://github.com/confluentinc/kafka/releases/tag/v3.2.0) release of Confluent Kafka distribution on the latest available Centos release.

You can pull it with:

    docker pull mcapitanio/kafka


You can also find other images based on different Apache Kafka releases, using a different tag in the following form:

    docker pull mcapitanio/kafka:[kafka-release]


For example, if you want the release 0.10.0.1 you can pull the image with:

    docker pull mcapitanio/kafka:0.10.0.1

Run with Docker Compose:

    docker-compose up

Once started you'll be able to read the Kafka Topics UI url:

**Kafka Topics UI url**:	http://localhost:8000

### Available tags:

- Apache Kafka 0.10.2.0 ([0.10.2.0](https://github.com/mcapitanio/docker-kafka/blob/0.10.2.0/Dockerfile), [latest](https://github.com/mcapitanio/docker-kafka/blob/latest/Dockerfile))
- Apache Kafka 0.10.0.1 ([0.10.0.1](https://github.com/mcapitanio/docker-kafka/blob/0.10.0.1/Dockerfile))