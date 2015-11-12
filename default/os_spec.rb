# encoding: utf-8
# author: Christoph Hartmann
# author: Dominik Richter

control '01' do
  impact 1.0
  title "trusted hosts login"
  desc "Rhosts/hosts.equiv files are a weak implemenation of authentication. Disabling the .rhosts and hosts.equiv support helps to prevent users from subverting the system's normal access control mechanisms of the system."
  describe command('find / -name \'.rhosts\'') do
    its('stdout') { should be_empty }
  end
  describe command('find / -name \'hosts.equiv\' ') do
    its('stdout') { should be_empty }
  end
end

control '02' do
  impact 1.0
  title "Dot in PATH variable"
  desc "Do not include the current working directory in PATH variable. This makes it easier for an attacker to gain extensive rigths by executing a Trojan program"
  describe command('echo $PATH') do
    its('stdout') { should_not include(":.:") }
  end
end
