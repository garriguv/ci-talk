class Deploy
  def initialize(deploy, paths, command_runner)
    @deploy = deploy
    @paths = paths
    @command_runner = command_runner
  end

  def deploy_hockey
    command_runner.run_command(hockey_cmd + hockey_payload + hockey_path)
  end

  private
  attr_reader :deploy, :paths, :command_runner

  def hockey_cmd
    ['curl', '-H', "X-HockeyAppToken:#{deploy.token}", '--silent']
  end

  def hockey_payload
    [
      '-F', "ipa=@#{paths.ipa_path}",
      '-F', "dsym=@#{paths.dsym_zip_path}",
      '-F', 'status=2'
    ]
  end

  def hockey_path
    ["https://rink.hockeyapp.net/api/2/apps/#{deploy.app_id}/app_versions/upload"]
  end
end
