class Archive
  attr_reader :directory, :base_name

  def initialize(directory, base_name)
    @directory = directory
    @base_name = base_name
  end
end
