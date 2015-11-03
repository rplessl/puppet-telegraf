require 'spec_helper'

describe 'telegraf' do
  context 'supported operating systems' do
     describe "telegraf class without any parameters on Ubuntu 14.04" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => 'debian',
          :lsbdistid => 'ubuntu',
          :lsbdistcodename => 'trusty',
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('telegraf::install').that_comes_before('telegraf::config') }
        it { is_expected.to contain_class('telegraf::config') }
        it { is_expected.to contain_class('telegraf::service').that_subscribes_to('telegraf::config') }

        it { is_expected.to contain_class('telegraf') }
     end
  end
end
