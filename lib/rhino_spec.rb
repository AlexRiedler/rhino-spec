require "rhino_spec/version"
require "dcell"

module RhinoSpec
  class SpecWorker
    include Celluloid

    def initialize
      puts "Client Started"
    end

    def run_spec(filename)
      # TODO: figure out how to do this
      #       probably call RSpec with custom formatter
      #       that calls back or returns something more useful
    end

  end

  class Server
    def initialize
      @worker_nodes =
        DCell::Node.select { |node| node.all.include?(:spec_worker) }
    end

    def run_all_tests()
      # TODO: determine set of tests to run,
      #       does RSpec still have a dry-run option?
      #       or do I need to do something here...
    end

    def run_tests(tests=nil)
      @worker_nodes.each do |node|
        node[:spec_worker].run_spec('spec/my_test_spec.rb')
      end
    end
  end
end
