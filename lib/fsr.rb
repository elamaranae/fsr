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
    Listen.to(*listen) do |modified, added|
      load = [modified, added].compact.flatten if load.empty?
      Fsr::Runner.new(run, load: load).run
    end
  end

  def self.sandboxed
    orig_world   = RSpec.world
    orig_example = RSpec.current_example
    RSpec.world  = RSpec::Core::World.new(RSpec.configuration)

    yield
  ensure
    RSpec.world           = orig_world
    RSpec.current_example = orig_example
    RSpec.clear_examples
  end

  # core runner
  class Runner
    def initialize(specs, load: [])
      @specs = specs
      @dependent_files = load
    end

    def run
      @dependent_files.each { |file| load(file) }
      Fsr.sandboxed do
        RSpec::Core::Runner.run(@specs)
      end
    end
  end
end
