# encoding: utf-8
#
# Copyright 2015, Patrick Muench
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
# author: Christoph Hartmann
# author: Dominik Richter
# author: Patrick Muench

control 'os-01' do
  impact 1.0
  title 'Trusted hosts login'
  desc "Rhosts/hosts.equiv files are a weak implemenation of authentication. Disabling the .rhosts and hosts.equiv support helps to prevent users from subverting the system's normal access control mechanisms of the system."
  describe command('find / -name \'.rhosts\'') do
    its('stdout') { should be_empty }
  end
  describe command('find / -name \'hosts.equiv\' ') do
    its('stdout') { should be_empty }
  end
end

control 'os-02' do
  impact 1.0
  title 'Check owner and permissions for /etc/shadow'
  desc 'Check periodically the owner and permissions for /etc/shadow'
  describe file('/etc/shadow') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq 'root' }
    it { should_not be_executable }
    it { should be_writable.by('owner') }
    it { should be_readable.by('owner') }
    it { should_not be_readable.by('group') }
    it { should_not be_readable.by('other') }
  end
end

control 'os-03' do
  impact 1.0
  title 'Check owner and permissions for /etc/passwd'
  desc 'Check periodically the owner and permissions for /etc/passwd'
  describe file('/etc/passwd') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq 'root' }
    it { should_not be_executable }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
  end
end

control 'os-04' do
  impact 1.0
  title 'Dot in PATH variable'
  desc 'Do not include the current working directory in PATH variable. This makes it easier for an attacker to gain extensive rigths by executing a Trojan program'
  describe os_env('PATH') do
    its('split') { should_not include('') }
    its('split') { should_not include('.') }
  end
end

control 'os-05' do
  impact 1.0
  title 'Check login.defs'
  desc 'Check owner and permissions for login.defs. Also check the configured PATH variable and umask in login.defs'
  describe file('/etc/login.defs') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq 'root' }
    it { should_not be_executable }
    it { should_not be_writable }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
  end
  describe login_defs do
    its('ENV_SUPATH') { should include('/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin') }
    its('ENV_PATH') { should include('/usr/local/bin:/usr/bin:/bin') }
    its('UMASK') { should include('027') }
    its('PASS_MAX_DAYS') { should eq '60' }
    its('PASS_MIN_DAYS') { should eq '7' }
    its('PASS_WARN_AGE') { should eq '7' }
    its('LOGIN_RETRIES') { should eq '5' }
    its('LOGIN_TIMEOUT') { should eq '60' }
    its('UID_MIN') { should eq '1000' }
    its('GID_MIN') { should eq '1000' }
    its('SYS_UID_MIN') { should eq '100' }
    its('SYS_UID_MAX') { should eq '999' }
    its('SYS_GID_MIN') { should eq '100' }
    its('SYS_GID_MAX') { should eq '999' }
    its('ENCRYPT_METHOD') { should eq 'SHA512' }
  end
end

control 'os-06' do
  impact 1.0
  title 'Check for SUID/ SGID blacklist'
  desc 'Find blacklisted SUID and SGID files to ensure that no rogue SUID and SGID files have been introduced into the system'

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
    '/usr/sbin/arping',
    '/usr/sbin/uuidd',
    '/usr/bin/mtr',                                               # investigate current state...
    '/usr/lib/evolution/camel-lock-helper-1.2',                   # investigate current state...
    '/usr/lib/pt_chown',                                          # pseudo-tty, needed?
    '/usr/lib/eject/dmcrypt-get-device',
    '/usr/lib/mc/cons.saver' # midnight commander screensaver
  ]

  output = command('find / -perm -4000 -o -perm -2000 -type f ! -path \'/proc/*\' -print 2>/dev/null | grep -v \'^find:\'')
  diff = output.stdout.split(/\r?\n/) & blacklist
  describe diff do
    it { should be_empty }
  end
end

control 'os-07' do
  impact 1.0
  title 'Unique uid and gid'
  desc 'Check for unique uids gids'
  describe passwd do
    its('uids') { should_not contain_duplicates }
  end
  describe etc_group do
    its('gids') { should_not contain_duplicates }
  end
end
