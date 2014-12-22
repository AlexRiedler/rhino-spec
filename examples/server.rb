#!/bin/ruby
require 'rhino_spec'
DCell.setup addr: 'tcp://127.0.0.1:9003', registry: { adapter: 'redis', host: 'localhost', port: 6379 }

DCell.start id: 'spec_distributor', addr: 'tcp://127.0.0.1:9002'
RhinoSpec::Server.supervise_as :spec_distributor
DCell::Node['spec_distributor'][:spec_distributor].run_all_tests()

sleep
