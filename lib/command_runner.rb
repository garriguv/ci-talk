class CommandRunner
  def unlock_keychain_and_run_command(cmd, password)
    keychain = File.join(Dir.home, 'Library/Keychains/login.keychain')
    keychain_cmd = %w(security unlock-keychain -p) + [password, keychain, '&&']
    run_command(keychain_cmd + cmd)
  end

  def run_command(cmd, log = true)
    puts cmd.join(' ') if log
    system(cmd.join(' '))
    unless $?.success?
      raise StandardError.new
    end
  end
end
