require 'rhino_spec'
DCell.setup addr: 'tcp://127.0.0.1:9003', registry: { adapter: 'redis', host: 'localhost', port: 6379 }

DCell.start id: 'spec_worker', addr: 'tcp://127.0.0.1:9002'
RhinoSpec::SpecWorker.supervise_as :spec_worker

server = RhinoSpec::Server.new
server.run_all_tests()

sleep
