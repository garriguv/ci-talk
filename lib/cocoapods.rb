require_relative 'command_runner'

class Cocoapods
  def initialize(command_runner)
    @command_runner = command_runner
  end

  def install_pods
    command_runner.run_command(['pod', 'install'])
  end

  private
  attr_reader :command_runner
end
