Gem::Specification.new do |s|
  s.name          = 'logstash-output-aerospike'
  s.version       = '0.3.11'
  s.licenses      = ['Apache License (2.0)']
  s.summary       = 'Logstash-output-aerospike, un unofficial logstash output plugin, is used for sending events to ARESPIKE.'
  s.description   = 'This plugin, logstash-output-aerospike, is not an official one, developed and maintained by ChaosLooCn on github. In order to use the plugin, you need a jarfile and put it in directory {logstash_home}/vendor/jruby/lib/. You can found the jarfile and it's source code at https://github.com/ChaosLooCn/logstash-output-aerospike-jar'
  s.homepage      = 'https://github.com/ChaosLooCn/logstash-output-aerospike'
  s.authors       = ['Tony Loo']
  s.email         = 'tonyloo92@163.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "logstash-codec-plain"
end
