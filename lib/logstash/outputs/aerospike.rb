# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "rubygems"
require "java"

# An aerospike output.
class LogStash::Outputs::Aerospike < LogStash::Outputs::Base

  config_name "aerospike"
  
  # Sets the host(s) of the remote instance.
  config :host
  
  # Global port configuration.
  config :port, :validate => :number, :default => 3000
  
  # Time to alive of records.
  config :ttl, :validate => :number, :default => 1296000
  
  # Mode to implement storing into aerospike.
  # "STD" means "standard", and store messages by the way of "client.put(policy,key,bins)".
  # "UDF" means "user defined function", and store messages by the way of 
  # "client.execute(policy,key,package,function,args)" to invoke a script aerospike side.
  config :mode, :validate => ["STD", "UDF"], :default => "STD"
  
  # Target namespace of aerospike.
  config :namespace, :validate => :string
  
  # Target set of aerospike.
  config :set, :validate => :string
  
  # Key of the record.
  config :key, :validate => :string
  
  # Bin names.
  config :binnames, :validate => :string
  
  # Bin types.
  config :bintypes, :validate => :string
   
  # Bins of the record
  config :binvalues, :validate => :string
  
  public
  def register
	@plugin = com.qihoo.unad.cminitializer.logstash.aero.plugin.LogstashAeroOutPlug.new
	@plugin.registerClient @host.to_s,@port.to_s,@namespace.to_s,@set.to_s,@ttl.to_s
	@plugin.startSender @host.to_s,@port.to_s,@namespace.to_s,@set.to_s,@ttl.to_s
  end # def register

  public
  def receive(event)
	@plugin.pushIntoQueue @host.to_s,@port.to_s,@namespace.to_s,@set.to_s,@ttl.to_s,event.sprintf(@key),@binnames.to_s,@bintypes.to_s,event.sprintf(@binvalues)
  end
end # class LogStash::Outputs::Aerospike
