require 'plist'
require 'fileutils'

class PlistGenerator
  def initialize(environment, plist_path)
    @environment = environment
    @plist_path = plist_path
  end

  def generate_plist
    File.open(plist_path, 'w') do |f|
      f.write(environment.to_plist)
    end
  end

  private
  attr_reader :environment, :plist_path

end
