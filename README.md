# **kafka**
___

### Description


This image runs:

 * the Confluent distribution of [*Apache Kafka*](https://github.com/confluentinc/kafka.git)
 * the Confluent [*Kafka REST Proxy*](https://github.com/confluentinc/kafka-rest.git)
 
on a Centos Linux distribution.

The *latest* tag of this image is build with the [latest stable](https://github.com/confluentinc/kafka/releases/tag/v3.2.2) release of Confluent Kafka distribution on the latest available Centos release.

You can pull it with:

    docker pull parrotcdc/kafka


You can also find other images based on different Apache Kafka releases, using a different tag in the following form:

    docker pull parrotcdc/kafka:[kafka-release]


For example, if you want the release 0.10.0.1 you can pull the image with:

    docker pull parrotcdc/kafka:0.10.0.1

Run with Docker Compose:

    docker-compose up

### Available tags:

- Apache Kafka 0.10.2.0 ([0.10.2.0](https://github.com/parrotcdc/docker-kafka/blob/0.10.2.0/Dockerfile), [latest](https://github.com/parrotcdc/docker-kafka/blob/latest/Dockerfile))
- Apache Kafka 0.10.0.1 ([0.10.0.1](https://github.com/parrotcdc/docker-kafka/blob/0.10.0.1/Dockerfile))
