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

describe 'IP V4 networking' do

  # DTAG SEC: Req 3.21-1
  context linux_kernel_parameter('net.ipv4.ip_forward') do
    its(:value) { should eq 0 }
  end

  # DTAG SEC: Req 3.21-1
  context linux_kernel_parameter('net.ipv4.conf.all.forwarding') do
    its(:value) { should eq 0 }
  end

  # DTAG SEC: Req 3.21-3
  context linux_kernel_parameter('net.ipv4.conf.all.rp_filter') do
    its(:value) { should eq 1 }
  end

  # DTAG SEC: Req 3.21-3 ; DTAG SEC: Req 3.37-10
  context linux_kernel_parameter('net.ipv4.conf.default.rp_filter') do
    its(:value) { should eq 1 }
  end

  # DTAG SEC: Req 3.21-1
  context linux_kernel_parameter('net.ipv4.icmp_echo_ignore_broadcasts') do
    its(:value) { should eq 1 }
  end

  context linux_kernel_parameter('net.ipv4.icmp_ignore_bogus_error_responses') do
    its(:value) { should eq 1 }
  end

  # DTAG SEC: Req 3.01-9
  context linux_kernel_parameter('net.ipv4.icmp_ratelimit') do
    its(:value) { should eq 100 }
  end

  context linux_kernel_parameter('net.ipv4.icmp_ratemask') do
    its(:value) { should eq 88089 }
  end

  context linux_kernel_parameter('net.ipv4.tcp_timestamps') do
    its(:value) { should eq 0 }
  end

  # DTAG SEC: Req 3.21-3
  context linux_kernel_parameter('net.ipv4.conf.all.arp_ignore') do
    its(:value) { should eq 1 }
  end

  # DTAG SEC: Req 3.21-3
  context linux_kernel_parameter('net.ipv4.conf.all.arp_announce') do
    its(:value) { should eq 2 }
  end

  context linux_kernel_parameter('net.ipv4.tcp_rfc1337') do
    its(:value) { should eq 1 }
  end

  context linux_kernel_parameter('net.ipv4.tcp_syncookies') do
    its(:value) { should eq 1 }
  end

  context linux_kernel_parameter('net.ipv4.conf.all.shared_media') do
    its(:value) { should eq 1 }
  end

  context linux_kernel_parameter('net.ipv4.conf.default.shared_media') do
    its(:value) { should eq 1 }
  end

  # DTAG SEC: Req 3.37-12
  context linux_kernel_parameter('net.ipv4.conf.all.accept_source_route') do
    its(:value) { should eq 0 }
  end

  # DTAG SEC: Req 3.37-12
  context linux_kernel_parameter('net.ipv4.conf.default.accept_source_route') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv4.conf.default.accept_redirects') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv4.conf.all.accept_redirects') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv4.conf.all.secure_redirects') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv4.conf.default.secure_redirects') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv4.conf.all.send_redirects') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv4.conf.all.send_redirects') do
    its(:value) { should eq 0 }
  end

  # log_martians can cause a denial of service attack to the host
  context linux_kernel_parameter('net.ipv4.conf.all.log_martians') do
    its(:value) { should eq 0 }
  end

end

describe 'IP V6 Networking' do

  context linux_kernel_parameter('net.ipv6.conf.all.disable_ipv6') do
    its(:value) { should eq 1 }
  end

  # DTAG SEC: Req 3.21-1
  context linux_kernel_parameter('net.ipv6.conf.all.forwarding') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.accept_redirects') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.all.accept_redirects') do
    its(:value) { should eq 0 }
  end

end

describe 'NSA 2.5.3.2.5 Limit Network-Transmitted Configuration' do

  context linux_kernel_parameter('net.ipv6.conf.default.router_solicitations') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.accept_ra_rtr_pref') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.accept_ra_pinfo') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.accept_ra_defrtr') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.autoconf') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.dad_transmits') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('net.ipv6.conf.default.max_addresses') do
    its(:value) { should eq 1 }
  end

end

describe 'System sysctl' do

  context linux_kernel_parameter('kernel.modules_disabled') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('kernel.sysrq') do
    its(:value) { should eq 0 }
  end

  context linux_kernel_parameter('fs.suid_dumpable') do
    its(:value) { should eq 0 }
  end
end

describe 'ExecShield' do

  # DTAG SEC: Req 3.21-5
  # check if we find the nx flag
  if command('cat /proc/cpuinfo').return_stdout?(/^flags.*?:.*? nx( .*?)?$/)
    true
  else
    # if no nx flag is present, we require exec-shield
    context 'No nx flag detected' do
      it 'require kernel.exec-shield' do
        context linux_kernel_parameter('kernel.exec-shield') do
          its(:value) { should eq 1 }
        end
      end
    end
  end

  # DTAG SEC: Req 3.21-5
  context linux_kernel_parameter('kernel.randomize_va_space') do
    its(:value) { should eq 2 }
  end
end
