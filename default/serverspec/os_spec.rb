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

require 'spec_helper'

RSpec.configure do |c|
  c.filter_run_excluding skipOn: backend(Serverspec::Commands::Base).check_os[:family]
end


describe command('find / -name \'.rhosts\' | wc -l ') do
  its(:stdout) { should match(/^0/) }
end


describe command('find / -name \'hosts.equiv\' | wc -l ') do
  its(:stdout) { should match(/^0/) }
end


describe file('/etc/shadow') do
  it { should be_owned_by 'root' }
end


describe file('/etc/shadow') do
  it { should be_mode 600 }
end


describe command('echo $PATH | grep -ci \'\.\'') do
  its(:stdout) { should match(/^0/) }
end


describe file('/etc/login.defs') do
  its(:content) { should match(%r{^ENV_SUPATH\s+PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin}) }
end


describe file('/etc/login.defs') do
  its(:content) { should match(%r{^ENV_PATH\s+PATH=/usr/local/bin:/usr/bin:/bin}) }
end


describe file('/etc/login.defs') do
  its(:content) { should match(/^UMASK +027/) }
end


describe 'SUID/ SGID blacklist  check' do
  it 'found no blacklisted suid/sgid' do
    blacklist = [
      # blacklist as provided by NSA
      '/usr/bin/rcp', '/usr/bin/rlogin', '/usr/bin/rsh',
      # sshd must not use host-based authentication (see ssh cookbook)
      '/usr/libexec/openssh/ssh-keysign',
      '/usr/lib/openssh/ssh-keysign',
      # misc others
      '/sbin/netreport',                                            # not normally required for user
      '/usr/sbin/usernetctl',                                       # modify interfaces via functional accounts
      # connecting to ...
      '/usr/sbin/userisdnctl',                                      # no isdn...
      '/usr/sbin/pppd',                                             # no ppp / dsl ...
      # lockfile
      '/usr/bin/lockfile',
      '/usr/bin/mail-lock',
      '/usr/bin/mail-unlock',
      '/usr/bin/mail-touchlock',
      '/usr/bin/dotlockfile',
      # need more investigation, blacklist for now
      '/usr/bin/arping',
      '/usr/sbin/uuidd',
      '/usr/bin/mtr',                                               # investigate current state...
      '/usr/lib/evolution/camel-lock-helper-1.2',                   # investigate current state...
      '/usr/lib/pt_chown',                                          # pseudo-tty, needed?
      '/usr/lib/eject/dmcrypt-get-device',
      '/usr/lib/mc/cons.saver'                                      # midnight commander screensaver
    ]

    actual = command('find / -perm -4000 -o -perm -2000 -type f ! -path \'/proc/*\' -print 2>/dev/null | grep -v \'^find:\'').stdout.split(/\r?\n/)
    (actual & blacklist).count.should be 0
  end
end


describe 'Unique uid' do
  it 'check for unique uids' do
    actual = command('cat /etc/passwd | cut -d \':\' -f 3').stdout.split(/\r?\n/)
    hm = actual.each_with_object(Hash.new(0)) { |d, counts| counts[d] += 1 }
    hm.each do |k, v|
      str = "User: UID #{k} instances: "
      ("#{str}#{v}").should eq("#{str}1")
    end
  end
end
