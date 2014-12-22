require "rhino_spec/version"
require "dcell"
require "rspec/core"

module RhinoSpec
  class SpecWorker
    include Celluloid

    def initialize
      puts "Client Started"
      $:.unshift 'spec' # add spec to the auto-load path
      @args = ["--format", "json"]
    end

    def run_spec(filename)
      puts "\nRUNNING TEST: #{filename}\n"
      args = @args + [filename]
      ::RSpec::reset
      ::RSpec::Core::Runner.run(args, err: $stderr, out: $stdout)
    end

  end

  class Server
    include Celluloid

    def initialize
      puts "Server Started"
      @worker_nodes =
        DCell::Node.select { |node| node.all.include?(:spec_worker) }
    end

    def run_all_tests()
      $:.unshift 'spec' # add spec to the load path

      # do rspec configuration
      begin
        RSpec.configuration.files_or_directories_to_run= ['spec/test_controller.rb']
        RSpec.configuration.load_spec_files
      end
      tests = RSpec.world.example_groups.map do |g|
        g.examples.map { |e| e.metadata[:location] }
      end
      run_tests(tests.flatten.uniq)
    end

    def run_tests(tests=nil)
      puts "RUNNING ALL TESTS: #{tests}"
      futures = []
      @worker_nodes.each do |node|
        futures << [node, node[:spec_worker].future.run_spec(tests.shift)]
      end
      while tests.length > 0
        while (ready_futures = futures.select { |n,f| f.ready? }) && tests.length > 0
          ready_futures.each do |node,future|
            futures << [node, node[:spec_worker].future.run_spec(tests.shift)] unless tests.length == 0
          end
          futures = futures - ready_futures
        end
      end
    end
  end
end
