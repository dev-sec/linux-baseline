if ENV['STANDALONE_SPEC']

  require 'serverspec'
  require 'pathname'
  require 'net/ssh'
  require 'highline/import'

  include Serverspec::Helper::Ssh
  include Serverspec::Helper::DetectOS

  RSpec.configure do |c|

    if ENV['ASK_SUDO_PASSWORD']
      c.sudo_password = ask('Enter sudo password: ') { |q| q.echo = false }
    else
      c.sudo_password = ENV['SUDO_PASSWORD']
    end

    options = {}

    if ENV['ASK_LOGIN_PASSWORD']
      options[:password] = ask("\nEnter login password: ") { |q| q.echo = false }
    else
      options[:password] = ENV['LOGIN_PASSWORD']
    end

    if ENV['ASK_LOGIN_USERNAME']
      user = ask("\nEnter login username: ") { |q| q.echo = false }
    else
      user = ENV['LOGIN_USERNAME'] || ENV['user'] || Etc.getlogin
    end

    if user.nil?
      puts 'specify login user env LOGIN_USERNAME= or user='
      exit 1
    end

    c.host  = ENV['TARGET_HOST']
    options.merge(Net::SSH::Config.for(c.host))
    c.ssh   = Net::SSH.start(c.host, user, options)
    c.os    = backend.check_os

  end

else
  require 'serverspec'

  include Serverspec::Helper::Exec
  include Serverspec::Helper::DetectOS

  RSpec.configure do |c|
    c.before :all do
      c.path = '/sbin:/usr/sbin'
    end
  end
end
