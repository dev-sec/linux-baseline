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

login_defs_umask = attribute('login_defs_umask', default: '027', description: 'Default umask to set in login.defs')
login_defs_passmaxdays = attribute('login_defs_passmaxdays', default: '60', description: 'Default password maxdays to set in login.defs')
login_defs_passmindays = attribute('login_defs_passmindays', default: '7', description: 'Default password mindays to set in login.defs')
login_defs_passwarnage = attribute('login_defs_passwarnage', default: '7', description: 'Default password warnage (days) to set in login.defs')
if os.redhat?
  shadow_group = 'root'
elsif os.debian?
  shadow_group = 'shadow'
end
blacklist = attribute(
  'blacklist',
  default: [
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
    # from Ubuntu xenial, need to investigate
    # '/sbin/unix_chkpwd',
    # '/sbin/pam_extrausers_chkpwd',
    # '/usr/lib/x86_64-linux-gnu/utempter/utempter',
    # '/usr/sbin/postdrop',
    # '/usr/sbin/postqueue',
    # '/usr/bin/ssh-agent',
    # '/usr/bin/mlocate',
    # '/usr/bin/crontab',
    # '/usr/bin/screen',
    # '/usr/bin/expiry',
    # '/usr/bin/wall',
    # '/usr/bin/chage',
    # '/usr/bin/bsd-write'
  ],
  description: 'blacklist of suid/sgid program on system'
)

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
    its('group') { should eq shadow_group }
    it { should_not be_executable }
    it { should be_writable.by('owner') }
    it { should be_readable.by('owner') }
    it { should_not be_readable.by('other') }
  end
  if os.redhat?
    describe file('/etc/shadow') do
      it { should_not be_readable.by('group') }
    end
  elsif os.debian?
    describe file('/etc/shadow') do
      it { should be_readable.by('group') }
    end
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
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
  end
  describe login_defs do
    its('ENV_SUPATH') { should include('/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin') }
    its('ENV_PATH') { should include('/usr/local/bin:/usr/bin:/bin') }
    its('UMASK') { should include(login_defs_umask) }
    its('PASS_MAX_DAYS') { should eq login_defs_passmaxdays }
    its('PASS_MIN_DAYS') { should eq login_defs_passmindays }
    its('PASS_WARN_AGE') { should eq login_defs_passwarnage }
    its('LOGIN_RETRIES') { should eq '5' }
    its('LOGIN_TIMEOUT') { should eq '60' }
    its('UID_MIN') { should eq '1000' }
    its('GID_MIN') { should eq '1000' }
  end
end

control 'os-05b' do
  impact 1.0
  title 'Check login.defs - RedHat specific'
  desc 'Check owner and permissions for login.defs. Also check the configured PATH variable and umask in login.defs'
  if os.redhat?
    describe file('/etc/login.defs') do
      it { should_not be_writable }
    end
    describe login_defs do
      its('SYS_UID_MIN') { should eq '100' }
      its('SYS_UID_MAX') { should eq '999' }
      its('SYS_GID_MIN') { should eq '100' }
      its('SYS_GID_MAX') { should eq '999' }
    end
  end
end

control 'os-06' do
  impact 1.0
  title 'Check for SUID/ SGID blacklist'
  desc 'Find blacklisted SUID and SGID files to ensure that no rogue SUID and SGID files have been introduced into the system'

  output = command('find / -perm -4000 -o -perm -2000 -type f ! -path \'/proc/*\' ! -path \'/var/lib/lxd/containers/*\' -print 2>/dev/null | grep -v \'^find:\'')
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

control 'os-08' do
  impact 1.0
  title 'Entropy'
  desc 'Check system has enough entropy - greater than 1000'
  describe file('/proc/sys/kernel/random/entropy_avail').content.to_i do
    it { should >= 1000 }
  end
end

control 'os-09' do
  impact 1.0
  title 'Check for .rhosts and .netrc file'
  desc 'Find .rhosts and .netrc files - CIS Benchmark 9.2.9-10'

  output = command('find / \( -iname .rhosts -o -iname .netrc \) -print 2>/dev/null | grep -v \'^find:\'')
  out = output.stdout.split(/\r?\n/)
  describe out do
    it { should be_empty }
  end
end

control 'os-10' do
  impact 1.0
  title "CIS: Disable unused filesystems"
  desc "1.1.1 Ensure mounting of cramfs, freevxfs, jffs2, hfs, hfsplus, squashfs, udf, FAT"
  describe file('/etc/modprobe.d/CIS.conf') do
    its(:content) { should match 'install cramfs /bin/true' }
    its(:content) { should match 'install freevxfs /bin/true' }
    its(:content) { should match 'install jffs2 /bin/true' }
    its(:content) { should match 'install hfs /bin/true' }
    its(:content) { should match 'install hfsplus /bin/true' }
    its(:content) { should match 'install squashfs /bin/true' }
    its(:content) { should match 'install udf /bin/true' }
    its(:content) { should match 'install vfat /bin/true' }
  end
end
