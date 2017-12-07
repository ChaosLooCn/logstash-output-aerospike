# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"

# An aerospike output that does nothing.
class LogStash::Outputs::Aerospike < LogStash::Outputs::Base
  config_name "aerospike"

  public
  def register
  end # def register

  public
  def receive(event)
    return "Event received"
  end # def event
end # class LogStash::Outputs::Aerospike
