require 'spec_helper'

describe 'System sysctl' do

    context linux_kernel_parameter('kernel.modules_disabled') do
        its(:value) { should eq 1 }
    end

end
