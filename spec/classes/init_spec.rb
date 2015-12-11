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

      it { is_expected.to contain_class('telegraf::params') }
      it { is_expected.to contain_class('telegraf::install').that_comes_before('telegraf::config') }
      it { is_expected.to contain_class('telegraf::config') }
      it { is_expected.to contain_class('telegraf::service').that_subscribes_to('telegraf::config') }

      it { is_expected.to contain_service('telegraf') }
      it { is_expected.to contain_package('telegraf').with_ensure('installed') }
      it { is_expected.to contain_class('telegraf') }
    end
    describe 'telegraf class without any parameters on Redhat/Centos' do
      let(:params) {{ }}
      let(:facts) {{
        :osfamily => 'redhat',
      }}

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('telegraf::params') }
      it { is_expected.to contain_class('telegraf::install').that_comes_before('telegraf::config') }
      it { is_expected.to contain_class('telegraf::config') }
      it { is_expected.to contain_class('telegraf::service').that_subscribes_to('telegraf::config') }

      it { is_expected.to contain_service('telegraf') }
      it { is_expected.to contain_package('telegraf').with_ensure('installed') }
      it { is_expected.to contain_class('telegraf') }
    end
  end

  context 'telegraf specific parameters' do
    let(:params) {{ }}
    let(:facts) {{
      :osfamily => 'debian',
      :lsbdistid => 'ubuntu',
      :lsbdistcodename => 'trusty',
    }}

    it { is_expected.to contain_file('/etc/opt/telegraf/telegraf.conf') }
    it { is_expected.to contain_file('/etc/opt/telegraf/telegraf.d') }
  end
end
