# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "rubygems"
require "aerospike"

include Aerospike

# An aerospike output.
class LogStash::Outputs::Aerospike < LogStash::Outputs::Base

  config_name "aerospike"
  
  # Sets the host(s) of the remote instance.
  mod.config :hosts, :validate => :uri, :default => [::LogStash::Util::SafeURI.new("//127.0.0.1")]

  # Global port configuration.
  mod.config :port, :validate => :number, :default => 3000
  
  # Time to alive of records.
  mod.config :expiration, :validate => :number, :default => 86400
  
  # Target namespace of aerospike
  mod.config :namespace, :validate => :string
  
  # Target set of aerospike
  mod.config :set, :validate => :string
  
    # Key of the record
  mod.config :key, :validate => :string
  
  # Bin names.
  mod.config :binnames, :validate => :string
  
  # Bin types.
  mod.config :bintyps, :validate => :string
   
  # Bins of the record
  mod.config :binvalues, :validate => :string
  
  public
  def register
    @write_policy = WritePolicy.new
    @write_policy.ttl = :expiration
    @client = Client.new(Host.new(hosts[0], @port))
  end # def register

  public
  def receive(event)
    names =	@binnames.split(',')
	types =	@bintypes.split(',')
	values = event.sprintf(@binvalues).split(',')
	$int = 0
	$num = names.size()
	bins = Array.new($num)
	
	while $i < $num  do
	  bins[names.at[$i]] = createBin(types.at[$i], values.at[$i])
	  $i+=1
    end
	
	@client.put(key, bins)
  end

  private
  def createBin(type, value)
    if type == 'string' then
	  return value
	else if type == 'integer' then
	  return value.oct
	end
  end
end # class LogStash::Outputs::Aerospike
