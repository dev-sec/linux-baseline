# encoding: utf-8
#
# Copyright 2014, Deutsche Telekom AG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if ENV['STANDALONE_SPEC']

  require 'serverspec'
  require 'pathname'
  require 'net/ssh'
  require 'highline/import'

  set :backend, :ssh

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
      options[:user] = ask("\nEnter login username: ") { |q| q.echo = false }
    else
      options[:user] = ENV['LOGIN_USERNAME'] || ENV['user'] || Etc.getlogin
    end

    if options[:user].nil?
      puts 'specify login user env LOGIN_USERNAME= or user='
      exit 1
    end

    c.host = ENV['TARGET_HOST']
    c.ssh_options = options.merge(Net::SSH::Config.for(c.host))

  end

else
  require 'serverspec'

  set :backend, :exec
end
