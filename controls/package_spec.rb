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

val_syslog_pkg = attribute('syslog_pkg', value: 'rsyslog', description: 'syslog package to ensure present (default: rsyslog, alternative: syslog-ng...')
container_execution = begin
                        virtualization.role == 'guest' && virtualization.system =~ /^(lxc|docker)$/
                      rescue NoMethodError
                        false
                      end

control 'package-01' do
  impact 1.0
  title 'Do not run deprecated inetd or xinetd'
  desc 'http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.1'
  describe package('inetd') do
    it { should_not be_installed }
  end
  describe package('xinetd') do
    it { should_not be_installed }
  end
end

control 'package-02' do
  impact 1.0
  title 'Do not install Telnet server'
  desc 'Telnet protocol uses unencrypted communication, that means the password and other sensitive data are unencrypted. http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.2'
  describe package('telnetd') do
    it { should_not be_installed }
  end
end

control 'package-03' do
  impact 1.0
  title 'Do not install rsh server'
  desc 'The r-commands suffers same problem as telnet. http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.3'
  describe package('rsh-server') do
    it { should_not be_installed }
  end
end

# package-04 is reserved, because we forgot to use it in the first-place :-)

control 'package-05' do
  impact 1.0
  title 'Do not install ypserv server (NIS)'
  desc 'Network Information Service (NIS) has some security design weaknesses like inadequate protection of important authentication information. http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.4'
  describe package('ypserv') do
    it { should_not be_installed }
  end
end

control 'package-06' do
  impact 1.0
  title 'Do not install tftp server'
  desc 'tftp-server provides little security http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.5'
  describe package('tftp-server') do
    it { should_not be_installed }
  end
end

control 'package-07' do
  impact 1.0
  title 'Install syslog server package'
  desc 'Syslog server is required to receive system and applications logs'
  # Fedora doesn't install with a syslogger out of the box and instead uses
  # systemd journal; as there is there is no affinity towards either rsyslog
  # or syslog-ng, we'll skip this check on Fedora hosts.
  only_if { os.name != 'fedora' && !container_execution }
  describe package(val_syslog_pkg) do
    it { should be_installed }
  end
end

control 'package-08' do
  impact 1.0
  title 'Install auditd'
  desc 'auditd provides extended logging capabilities on recent distributions'
  only_if { !container_execution }
  audit_pkg = os.redhat? || os.suse? || os.name == 'amazon' || os.name == 'fedora' ? 'audit' : 'auditd'
  describe package(audit_pkg) do
    it { should be_installed }
  end
  describe auditd_conf do
    its('log_file') { should cmp '/var/log/audit/audit.log' }
    its('log_format') { should cmp 'raw' }
    its('flush') { should match(/^incremental|INCREMENTAL|incremental_async|INCREMENTAL_ASYNC$/) }
    its('max_log_file_action') { should cmp 'keep_logs' }
    its('space_left') { should cmp 75 }
    its('action_mail_acct') { should cmp 'root' }
    its('space_left_action') { should cmp 'SYSLOG' }
    its('admin_space_left') { should cmp 50 }
    its('admin_space_left_action') { should cmp 'SUSPEND' }
    its('disk_full_action') { should cmp 'SUSPEND' }
    its('disk_error_action') { should cmp 'SUSPEND' }
  end
end

control 'package-09' do
  impact 1.0
  title 'CIS: Additional process hardening'
  desc '1.5.4 Ensure prelink is disabled'
  describe package('prelink') do
    it { should_not be_installed }
  end
end
