require 'rake'
require 'rake/clean'
require_relative 'lib/configuration'
require_relative 'lib/build'
require_relative 'lib/ipa'
require_relative 'lib/deploy'
require_relative 'lib/cocoapods'
require_relative 'lib/plist_generator'
require_relative 'lib/paths'
require_relative 'lib/command_runner'

CLEAN.include(Configuration.archive.directory)
CLOBBER.include('Pods/')

namespace 'build' do
  desc 'clean the build'
  task :clean do
    build.clean
  end

  desc 'build the app'
  task :build => [:plist] do
    build.build_app
  end

  desc 'generate an installable app (simulator)'
  task :sim_app => [:plist] do
    build.build_simulator_app
  end
end

namespace 'ci' do
  desc 'ci pipeline'
  task :ci => [:clobber, :pods, :unit_test]

  desc 'run the unit test suite'
  task :unit_test => [:plist] do
    build.run_unit_test_suite
  end
end

namespace 'ipa' do
  desc 'build an installable ipa'
  task :ipa => ['build:build'] do
    ipa.package_ipa
  end

  desc 'sign an existing ipa in the target folder'
  task :sign_ipa do
    ipa.sign_ipa
  end
end

namespace 'deploy' do
  desc 'upload ipa to HockeyApp'
  task :hockey do
    deploy.deploy_hockey
  end
end

desc 'generate environment plist'
task :plist do
  plist_generator.generate_plist
end

desc 'install pods'
task :pods do
  cocoapods.install_pods
end

def build
  Build.new(Configuration.app, Configuration.simulator, Configuration.archive, Configuration.codesign, paths, command_runner)
end

def ipa
  Ipa.new(Configuration.codesign, Configuration.archive, paths, command_runner)
end

def deploy
  Deploy.new(Configuration.hockey, paths, command_runner)
end

def cocoapods
  Cocoapods.new(command_runner)
end

def plist_generator
  PlistGenerator.new(Configuration.environment, Configuration.app.environment_plist)
end

def paths
  Paths.new(Configuration.app, Configuration.archive, Configuration.build_env)
end

def command_runner
  CommandRunner.new
end
