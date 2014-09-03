class Simulator
  attr_reader :sdk, :destination

  def initialize(sdk, destination)
    @sdk = sdk
    @destination = destination
  end
end
