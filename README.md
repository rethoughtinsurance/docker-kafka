# **kafka**
___

### Description


This image runs the official [*Apache Kafka*](http://kafka.apache.org/) and [*Yahoo Kafka Manager*](https://github.com/yahoo/kafka-manager) on a Centos Linux distribution.

The *latest* tag of this image is build with the [latest stable](http://kafka.apache.org/downloads.html) release of Apache Kafka on the latest available Centos release.

You can pull it with:

    docker pull mcapitanio/kafka


You can also find other images based on different Apache Kafka releases, using a different tag in the following form:

    docker pull mcapitanio/kafka:[kafka-release]


For example, if you want the release 0.9.0.1 you can pull the image with:

    docker pull mcapitanio/kafka:0.9.0.1

Run with Docker Compose:

    docker-compose -p docker up

Setting the project name to *docker* with the **-p** option is useful to share the named data volumes created by containers started with other docker-compose.yml configurations of mine.

Once started you'll be able to read the Yahoo Kafka Manager url for your environment (plase note that the ip is non static!):

**Yahoo Kafka Manager url**:	http://172.17.0.3:8081

### Available tags:

- Apache Kafka 0.10.0.1 ([0.10.0.1](https://github.com/mcapitanio/docker-kafka/blob/0.10.0.1/Dockerfile), [latest](https://github.com/mcapitanio/docker-kafka/blob/latest/Dockerfile))
