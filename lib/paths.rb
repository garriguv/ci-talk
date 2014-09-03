class Paths
  def initialize(app, archive, build_env)
    @app = app
    @archive = archive
    @build_env = build_env
  end

  def product_name
    [
      archive.base_name,
      app.version,
      build_env,
      app.configuration
    ].join('-')
  end

  def app_path
    File.absolute_path(product_name + '.app', archive.directory)
  end

  def ipa_path
    File.absolute_path(product_name + '.ipa', archive.directory)
  end

  def dsym_path
    File.absolute_path(product_name + '.app.dSYM', archive.directory)
  end

  def dsym_zip_path
    File.absolute_path(product_name + '.app.dSYM.zip', archive.directory)
  end

  private
  attr_reader :app, :archive, :build_env
end
