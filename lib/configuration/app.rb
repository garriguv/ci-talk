module Configuration
  class App
    attr_reader :workspace, :scheme, :configuration, :display_name, :bundle_identifier, :version, :environment_plist

    def initialize(workspace, scheme, configuration, display_name, bundle_identifier, version, environment_plist)
      @workspace = workspace
      @scheme = scheme
      @configuration = configuration
      @display_name = display_name
      @bundle_identifier = bundle_identifier
      @version = version
      @environment_plist = environment_plist
    end
  end
end
