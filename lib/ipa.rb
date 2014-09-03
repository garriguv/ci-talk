require_relative 'command_runner'

class Ipa
  def initialize(codesign, archive, paths, command_runner)
    @codesign = codesign
    @archive = archive
    @paths = paths
    @command_runner = command_runner
  end

  def package_ipa
    generate_ipa(paths.app_path)
  end

  def sign_ipa
    generate_ipa(existing_app_path)
  end

  private
  attr_reader :codesign, :archive, :paths, :command_runner

  def generate_ipa(path)
    cmd = [
      'xcrun',
      '-sdk', 'iphoneos',
      'PackageApplication',
      '-v',
      path,
      '-o', paths.ipa_path,
      '--sign', codesign.signing_identity,
      '--embed', codesign.provisioning_profile
    ]
    command_runner.run_command(cmd)
  end

  def existing_app_path
    filename = Dir.new(archive.directory).select {|f| File.extname(f) == '.app'}.first
    File.absolute_path(filename, archive.directory)
  end
end
