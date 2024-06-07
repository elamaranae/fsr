# frozen_string_literal: true

require_relative 'fsr/version'
require 'listen'

# Run RSpec fast by avoiding full app boot
#
# ```rb
#   listener = Fsr.listen(
#     ['spec/controllers/task_controller_spec.rb'],
#     load: ['app/controllers/task_controller.rb']
#   )
#
#   listener.start
#   listener.stop
# ```
module Fsr
  def self.listen(
    run,
    load: [],
    listen:
      [
        "#{`pwd`.strip}/app",
        "#{`pwd`.strip}/lib",
        "#{`pwd`.strip}/spec"
      ].select { |dir| Dir.exist?(dir) }
  )
    Listen.to(*listen) { Fsr::Runner.new(run, load: load).run }
  end

  # core runner
  class Runner
    def initialize(specs, load: [])
      @specs = specs
      @dependent_files = load
    end

    def run
      @dependent_files.each { |file| load(file) }
      RSpec::Core::Runner.run(@specs)
      cleanup
    end

    def cleanup
      warn_level = $VERBOSE
      $VERBOSE = nil
      remove_rspec
      require('rspec')
      configure
      $VERBOSE = warn_level
    end

    def remove_rspec
      Object.send(:remove_const, 'RSpec')
      $LOADED_FEATURES.reject! { |a| a.include?('rspec') }
    end

    def configure
      load('spec/spec_helper.rb')
      load('spec/rails_helper.rb')
    end
  end
end
