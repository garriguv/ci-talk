require_relative 'configuration/app'
require_relative 'configuration/archive'
require_relative 'configuration/codesign'
require_relative 'configuration/hockey'
require_relative 'configuration/simulator'

module Configuration
  extend self

  def app
    App.new(
      setting(:app, :workspace),
      setting(:app, :scheme),
      setting(:app, :configuration),
      setting(:app, :display_name),
      setting(:app, :bundle_identifier),
      setting(:app, :version),
      setting(:app, :environment_plist)
    )
  end

  def archive
    Archive.new(
      setting(:archive, :directory),
      setting(:archive, :base_name)
    )
  end

  def codesign
    Codesign.new(
      setting(:codesign, :signing_identity),
      setting(:codesign, :provisioning_profile)
    )
  end

  def hockey
    Hockey.new(
      setting(:deploy, :token),
      setting(:deploy, :app_id)
    )
  end

  def simulator
    Simulator.new(
      setting(:simulator, :sdk),
      setting(:simulator, :destination)
    )
  end

  def environment
    configuration['environment']
  end

  def setting(prefix, key)
    configuration[prefix.to_s][key.to_s]
  end

  def configuration
    @configuration ||= YAML.load_file('.build.yml')[build_env]
  end

  def build_env
    ENV['BUILD_ENV'] || 'development'
  end
end
