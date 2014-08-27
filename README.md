#ActiveMQ Consumer
##Description
Helper to get messages from an ActiveMQ queue
##Example
```
require 'activemq_consumer'

consumer=ActiveMQConsumer.new("tcp://localhost:61616", "some-queue")
consumer.clear_all_messages
message=consumer.get_message
consumer.close
```
