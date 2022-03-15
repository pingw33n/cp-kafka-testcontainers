`confluentinc/cp-kafka` replacement for Testcontainers.

This image attempts to mimic `confluentinc/cp-kafka` adding support for M1 Mac architecture. The primary use case is to build it locally and used from [Testcontainers](https://www.testcontainers.org), other scenarios were not tested and are not recommended.

Build
-----
```
$ ./build 6.1.0 7.0.0 7.0.1 latest
```

You need to list all versions planned to be used to prevent original image being fetched from Docker Hub.

Credits
-------
Based on https://github.com/hey-johnnypark/docker-kafka-zookeeper
