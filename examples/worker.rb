#!/bin/ruby
require 'rhino_spec'
DCell.setup addr: 'tcp://127.0.0.1:9003', registry: { adapter: 'redis', host: 'localhost', port: 6379 }
DCell.start addr: "tcp://127.0.0.1:#{ARGV[0]}"
RhinoSpec::SpecWorker.supervise_as :spec_worker
sleep
