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

sysctl_forwarding = attribute('sysctl_forwarding', value: false, description: 'Is network forwarding needed?')
kernel_modules_disabled = attribute('kernel_modules_disabled', value: 0, description: 'Should loading of kernel modules be disabled?')
container_execution = begin
                        virtualization.role == 'guest' && virtualization.system =~ /^(lxc|docker)$/
                      rescue NoMethodError
                        false
                      end

control 'sysctl-01' do
  impact 1.0
  title 'IPv4 Forwarding'
  desc "If you're not intending for your system to forward traffic between interfaces, or if you only have a single interface, the forwarding function must be disable."
  only_if { sysctl_forwarding == false && !container_execution }
  describe kernel_parameter('net.ipv4.ip_forward') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv4.conf.all.forwarding') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-02' do
  impact 1.0
  title 'Reverse path filtering'
  desc "The rp_filter can reject incoming packets if their source address doesn't match the network interface that they're arriving on, which helps to prevent IP spoofing."
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.rp_filter') do
    its(:value) { should eq 1 }
  end
  describe kernel_parameter('net.ipv4.conf.default.rp_filter') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-03' do
  impact 1.0
  title 'ICMP ignore bogus error responses'
  desc 'Sometimes routers send out invalid responses to broadcast frames. This is a violation of RFC 1122 and the kernel will logged this. To avoid filling up your logfile with unnecessary stuff, you can tell the kernel not to issue these warnings'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.icmp_ignore_bogus_error_responses') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-04' do
  impact 1.0
  title 'ICMP echo ignore broadcasts'
  desc 'Blocking ICMP ECHO requests to broadcast addresses'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.icmp_echo_ignore_broadcasts') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-05' do
  impact 1.0
  title 'ICMP ratelimit'
  desc 'icmp_ratelimit defines how many packets that match the icmp_ratemask per second'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.icmp_ratelimit') do
    its(:value) { should eq 100 }
  end
end

control 'sysctl-06' do
  impact 1.0
  title 'ICMP ratemask'
  desc 'Ratemask is a logical OR of all ICMP codes to rate limit'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.icmp_ratemask') do
    its(:value) { should eq 88089 }
  end
end

control 'sysctl-07' do
  impact 1.0
  title 'TCP timestamps'
  desc "It is possible to estimate the current uptime of a Linux system. It's preferable to disable TCP timestamps on your systems."
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.tcp_timestamps') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-08' do
  impact 1.0
  title 'ARP ignore'
  desc 'Reply only if the target IP address is local address configured on the incoming interface.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.arp_ignore') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-09' do
  impact 1.0
  title 'ARP announce'
  desc 'Always use the best local address for this target. In this mode we ignore the source address in the IP packet and try to select local address that we prefer for talks with	the target host.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.arp_announce') do
    its(:value) { should eq 2 }
  end
end

control 'sysctl-10' do
  impact 1.0
  title 'TCP RFC1337 Protect Against TCP Time-Wait'
  desc 'This enables a fix for time-wait assassination hazards in tcp, described in RFC 1337. If enabled, this causes the kernel to drop RST packets for sockets in the time-wait state.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.tcp_rfc1337') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-11' do
  impact 1.0
  title 'Protection against SYN flood attacks'
  desc 'A SYN-Attack is a denial of service (DoS) attack that consumes resources on your system forcing you to reboot.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.tcp_syncookies') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-12' do
  impact 1.0
  title 'Shared Media IP Architecture'
  desc 'Send(router) or accept(host) RFC1620 shared media redirects. If it is not set the kernel does not assume that different subnets on this device can communicate directly.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.shared_media') do
    its(:value) { should eq 1 }
  end
  describe kernel_parameter('net.ipv4.conf.default.shared_media') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-13' do
  impact 1.0
  title 'Disable Source Routing'
  desc 'The accept_source_route option causes network interfaces to accept packets with the Strict Source Route (SSR) or Loose Source Routing (LSR) option set. An attacker is able to send a source routed packet into the network, then he could intercept the replies and your server might not know that it is not communicating with a trusted server'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.accept_source_route') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv4.conf.default.accept_source_route') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-14' do
  impact 1.0
  title 'Disable acceptance of all IPv4 redirected packets'
  desc 'Disable acceptance of all redirected packets these prevents Man-in-the-Middle attacks.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.default.accept_redirects') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv4.conf.all.accept_redirects') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-15' do
  impact 1.0
  title 'Disable acceptance of all secure redirected packets'
  desc 'Disable acceptance of all secure redirected packets these prevents Man-in-the-Middle attacks.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.secure_redirects') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv4.conf.default.secure_redirects') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-16' do
  impact 1.0
  title 'Disable sending of redirects packets'
  desc 'Disable sending of redirects packets'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.default.send_redirects') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv4.conf.all.send_redirects') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-17' do
  impact 1.0
  title 'Disable log martians'
  desc 'log_martians can cause a denial of service attack to the host'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv4.conf.all.log_martians') do
    its(:value) { should eq 1 }
  end
  describe kernel_parameter('net.ipv4.conf.default.log_martians') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-18' do
  impact 1.0
  title 'Disable IPv6 if it is not needed'
  desc 'Disable IPv6 if it is not needed'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.all.disable_ipv6') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-19' do
  impact 1.0
  title 'IPv6 Forwarding'
  desc "If you're not intending for your system to forward traffic between interfaces, or if you only have a single interface, the forwarding function must be disable."
  only_if { sysctl_forwarding == false && !container_execution }
  describe kernel_parameter('net.ipv6.conf.all.forwarding') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-20' do
  impact 1.0
  title 'Disable acceptance of all IPv6 redirected packets'
  desc 'Disable acceptance of all redirected packets these prevents Man-in-the-Middle attacks.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.accept_redirects') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv6.conf.all.accept_redirects') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-21' do
  impact 1.0
  title 'Disable acceptance of IPv6 router solicitations messages'
  desc 'The router solicitations setting determines how many router solicitations are sent when bringing up the interface. If addresses are statically assigned, there is no need to send any solicitations.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.router_solicitations') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-22' do
  impact 1.0
  title 'Disable Accept Router Preference from router advertisement'
  desc 'Disable Accept Router Preference from router advertisement'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.accept_ra_rtr_pref') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-23' do
  impact 1.0
  title 'Disable learning Prefix Information from router advertisement'
  desc 'The accept_ra_pinfo setting controls whether the system will accept prefix info from the router.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.accept_ra_pinfo') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-24' do
  impact 1.0
  title 'Disable learning Hop limit from router advertisement'
  desc 'The accept_ra_defrtr setting controls whether the system will accept Hop Limit settings from a router advertisement. Setting it to 0 prevents a router from changing your default IPv6 Hop Limit for outgoing packets.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.accept_ra_defrtr') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-25' do
  impact 1.0
  title 'Disable the system`s acceptance of router advertisement'
  desc 'Setting controls whether the system will accept router advertisement'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.all.accept_ra') do
    its(:value) { should eq 0 }
  end
  describe kernel_parameter('net.ipv6.conf.default.accept_ra') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-26' do
  impact 1.0
  title 'Disable IPv6 autoconfiguration'
  desc 'The autoconf setting controls whether router advertisements can cause the system to assign a global unicast address to an interface.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.autoconf') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-27' do
  impact 1.0
  title 'Disable neighbor solicitations to send out per address'
  desc 'The dad_transmits setting determines how many neighbor solicitations to send out per address (global and link-local) when bringing up an interface to ensure the desired address is unique on the network.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.dad_transmits') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-28' do
  impact 1.0
  title 'Assign one global unicast IPv6 addresses to each interface'
  desc 'The max_addresses setting determines how many global unicast IPv6 addresses can be assigned to each interface. The default is 16, but it should be set to exactly the number of statically configured global addresses required.'
  only_if { !container_execution }
  describe kernel_parameter('net.ipv6.conf.default.max_addresses') do
    its(:value) { should eq 1 }
  end
end

control 'sysctl-29' do
  impact 1.0
  title 'Disable loading kernel modules'
  desc 'The sysctl key kernel.modules_disabled is very straightforward. If it contains a "1" it will disable loading new modules, where a "0" will still allow loading them. Using this option will be a great protection against loading malicious kernel modules.'
  only_if { !container_execution }
  describe kernel_parameter('kernel.modules_disabled') do
    its(:value) { should eq kernel_modules_disabled }
  end
end

control 'sysctl-30' do
  impact 1.0
  title 'Magic SysRq'
  desc "Kernel.sysreg is a 'magical' key combo you can hit which the kernel will respond to regardless of whatever else it is doing, unless it is completely locked up."
  only_if { !container_execution }
  describe kernel_parameter('kernel.sysrq') do
    its(:value) { should eq 0 }
  end
end

control 'sysctl-31a' do
  impact 1.0
  title 'Secure Core Dumps - dump settings'
  desc 'Ensure that core dumps can never be made by setuid programs'
  only_if { !container_execution }
  describe kernel_parameter('fs.suid_dumpable') do
    its(:value) { should cmp(/(0|2)/) }
  end
end

control 'sysctl-31b' do
  impact 1.0
  title 'Secure Core Dumps - dump path'
  desc 'Ensure that core dumps are done with fully qualified path'
  only_if { kernel_parameter('fs.suid_dumpable').value == 2 && !container_execution }
  describe kernel_parameter('kernel.core_pattern') do
    its(:value) { should match %r{^\|?/.*} }
  end
end

control 'sysctl-32' do
  impact 1.0
  title 'kernel.randomize_va_space'
  desc 'kernel.randomize_va_space'
  only_if { !container_execution }
  describe kernel_parameter('kernel.randomize_va_space') do
    its(:value) { should eq 2 }
  end
end

control 'sysctl-33' do
  impact 1.0
  title 'CPU No execution Flag or Kernel ExecShield'
  desc 'Kernel features and CPU flags provide a protection against buffer overflows. The CPU NX Flag and the kernel parameter exec-shield prevents code execution on a per memory page basis. If the CPU supports the NX-Flag then this should be used instead of the kernel parameter exec-shield.'
  only_if { !container_execution }

  # parse for cpu flags
  flags = parse_config_file('/proc/cpuinfo', assignment_regex: /^([^:]*?)\s+:\s+(.*?)$/).flags
  flags ||= ''
  flags = flags.split(' ')

  describe '/proc/cpuinfo' do
    it 'Flags should include NX' do
      expect(flags).to include('nx')
    end
  end

  unless flags.include?('nx')
    # if no nx flag is present, we require exec-shield
    describe kernel_parameter('kernel.exec-shield') do
      its(:value) { should eq 1 }
    end
  end
end
