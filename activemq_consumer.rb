require 'java'
require 'activemq'

# Class to connect to an ActiveMQ queue and consume messages
class ActiveMQConsumer

  def initialize(connection_string, queue)
    @connection_string = connection_string
    @connection_factory = Java::OrgApacheActivemq::ActiveMQConnectionFactory.new(@connection_string)
    @connection = @connection_factory.create_connection
    @session = @connection.create_session(false, Java::JavaxJms::Session::AUTO_ACKNOWLEDGE)
    destination = @session.createQueue queue
    @consumer = @session.createConsumer destination
    @connection.start
  end

  def get_message(timeout_secs=30)
    @consumer.receive(timeout_secs * 1000)
  end

  def clear_all_messages
    while get_message(0.1)
    end
  end

  def close
    @consumer.stop
    @consumer.close
    @session.stop
    @session.close
    @connection.stop
    @connection.close
  end

end
