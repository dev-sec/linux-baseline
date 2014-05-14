require 'spec_helper'

describe 'preloaded modules' do
    describe file('/etc/initramfs-tools/modules') do
        before do
            if (RSpec.configuration.os[:family] != 'Debian') 
                pending "initramfs creation not ported to this platform yet"
            end
        end

        its(:content) { should match /^ghash-clmulni-intel/ }
        its(:content) { should match /^aesni-intel/ }
        its(:content) { should match /^kvm-intel/ }
    end
end
