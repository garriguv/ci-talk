require_relative 'configuration/app'
require_relative 'command_runner'
require 'fileutils'

class Build
  def initialize(app, simulator, archive, codesign, paths, command_runner)
    @app = app
    @simulator = simulator
    @archive = archive
    @codesign = codesign
    @paths = paths
    @command_runner = command_runner
  end

  def clean
    xcodebuild('clean')
  end

  def run_unit_test_suite
    xcodebuild(['-sdk', simulator.sdk, '-destination', simulator.destination, 'clean', 'test'])
  end

  def build_app
    cmd = [
      '-sdk', 'iphoneos',
      "CONFIGURATION_BUILD_DIR=#{archive.directory}",
      "PRODUCT_NAME=#{paths.product_name}",
      'build'
    ]
    xcodebuild(cmd, true)
    zip_dsym
  end

  def build_simulator_app
    cmd = [
      '-sdk', simulator.sdk,
      '-destination', simulator.destination,
      "CONFIGURATION_BUILD_DIR=#{archive.directory}",
      "PRODUCT_NAME=#{paths.product_name}",
      'build'
    ]
    xcodebuild(cmd)
  end

  private
  attr_reader :app, :simulator, :archive, :codesign, :paths, :command_runner

  def xcodebuild(cmd, unlock_keychain = false)
    xcodebuild_cmd = xcodebuild_base_cmd.push(cmd).flatten
    if unlock_keychain && ENV['KEYCHAIN_PASSWORD']
      command_runner.unlock_keychain_and_run_command(xcodebuild_cmd, ENV['KEYCHAIN_PASSWORD'])
    else
      command_runner.run_command(xcodebuild_cmd)
    end
  end

  def zip_dsym
    command_runner.run_command(['zip', '-q', '-r', paths.dsym_zip_path, paths.dsym_path])
  end

  def xcodebuild_base_cmd
    [
      'xcodebuild',
      '-workspace', app.workspace,
      '-scheme', app.scheme,
      '-configuration', app.configuration,
      "CI_BUNDLE_IDENTIFIER=#{app.bundle_identifier}",
      "CI_SIGNING_IDENTITY=#{codesign.signing_identity}",
      "CI_DISPLAY_NAME=#{app.display_name}",
      "CI_VERSION=#{app.version}",
      "CI_BUILD=#{build_number}"
    ]
  end

  def build_number
    ENV['CI_BUILD_NUMBER'] || app.version
  end
end
