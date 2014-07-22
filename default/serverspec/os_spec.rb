# encoding: utf-8

require 'spec_helper'

RSpec.configure do |c|
  c.filter_run_excluding skipOn: backend(Serverspec::Commands::Base).check_os[:family]
end

# GIS: Req 3.21-4
describe command('find / -name \'.rhosts\' | wc -l ') do
  its(:stdout) { should match(/^0/) }
end

# GIS: Req 3.21-4
describe command('find / -name \'hosts.equiv\' | wc -l ') do
  its(:stdout) { should match(/^0/) }
end

# GIS: Req 3.21-7
describe file('/etc/shadow') do
  it { should be_owned_by 'root' }
end

# GIS: Req 3.21-7
describe file('/etc/shadow') do
  it { should be_mode 600 }
end

# GIS: Req 3.21-8
describe command('echo $PATH | grep -ci \'\.\'') do
  its(:stdout) { should match(/^0/) }
end

# GIS: Req 3.21-8
describe file('/etc/login.defs') do
  its(:content) { should match(%r{^ENV_SUPATH\s+PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin}) }
end

# GIS: Req 3.21-8
describe file('/etc/login.defs') do
  its(:content) { should match(%r{^ENV_PATH\s+PATH=/usr/local/bin:/usr/bin:/bin}) }
end

# GIS: Req 3.21-10
describe file('/etc/login.defs') do
  its(:content) { should match(/^UMASK +027/) }
end

# GIS: Req 3.21-12
describe 'SUID/ SGID whitelist check' do
  it 'found only whitelist suid/sgid' do
    whitelist  = [
      # whitelist as provided by NSA
      '/bin/mount', '/bin/ping', '/bin/su', '/bin/umount', '/sbin/pam_timestamp_check',
      '/sbin/unix_chkpwd', '/usr/bin/at', '/usr/bin/gpasswd', '/usr/bin/locate',
      '/usr/bin/newgrp', '/usr/bin/passwd', '/usr/bin/ssh-agent', '/usr/libexec/utempter/utempter', '/usr/sbin/lockdev',
      '/usr/sbin/sendmail.sendmail', '/usr/bin/expiry',
      # whitelist ipv6
      '/bin/ping6', '/usr/bin/traceroute6.iputils',
      # whitelist nfs
      '/sbin/mount.nfs', '/sbin/umount.nfs',
      # whitelist nfs4
      '/sbin/mount.nfs4', '/sbin/umount.nfs4',
      # whitelist cron
      '/usr/bin/crontab',
      # whitelist consolemssaging
      '/usr/bin/wall', '/usr/bin/write',
      # whitelist: only SGID with utmp group for multi-session access
      #            impact is limited; installation/usage has some remaining risk
      '/usr/bin/screen',
      # whitelist locate
      '/usr/bin/mlocate',
      # whitelist usermanagement
      '/usr/bin/chage', '/usr/bin/chfn', '/usr/bin/chsh',
      # whitelist fuse
      '/bin/fusermount',
      # whitelist pkexec
      '/usr/bin/pkexec',
      # whitelist sudo
      '/usr/bin/sudo', '/usr/bin/sudoedit',
      # whitelist postfix
      '/usr/sbin/postdrop', '/usr/sbin/postqueue',
      # whitelist apache
      '/usr/sbin/suexec',
      # whitelist squid
      '/usr/lib/squid/ncsa_auth', '/usr/lib/squid/pam_auth',
      # whitelist kerberos
      '/usr/kerberos/bin/ksu',
      # whitelist pam_caching
      '/usr/sbin/ccreds_validate',
      # whitelist Xorg
      '/usr/bin/Xorg',                                              # xorg
      '/usr/bin/X',                                                 # xorg
      '/usr/lib/dbus-1.0/dbus-daemon-launch-helper',                # freedesktop ipc
      '/usr/lib/vte/gnome-pty-helper',                              # gnome
      '/usr/lib/libvte9/gnome-pty-helper',                          # gnome
      '/usr/lib/libvte-2.90-9/gnome-pty-helper'                     # gnome
    ]
    actual = command('find / -perm -4000 -o -perm -2000 -type f ! -path \'/proc/*\' -print 2>/dev/null | grep -v \'^find:\'').stdout.split(/\r?\n/)
    (actual - whitelist).count.should be 0
  end
end

# GIS: Req 3.21-16
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
