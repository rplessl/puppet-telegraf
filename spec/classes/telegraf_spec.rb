require 'spec_helper'

describe 'telegraf' do

  context 'supported operating systems' do

    ['Debian', 'RedHat'].each do |osfamily|
      describe "telegraf class without any parameters on Ubuntu 14.04" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('telegraf::params') }
        it { is_expected.to contain_class('::telegraf::install').that_comes_before('::telegraf::config') }
        it { is_expected.to contain_class('telegraf::config') }
        it { is_expected.to contain_class('::telegraf::service').that_subscribes_to('::telegraf::config') }
        it { is_expected.to contain_class('telegraf::cleanup') }
        it { is_expected.to contain_class('::telegraf::service').that_comes_before('::telegraf::cleanup') }


        it { is_expected.to contain_service('telegraf') }
        it { is_expected.to contain_package('telegraf').with_ensure('installed') }
        it { is_expected.to contain_class('telegraf') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'telegraf class without any parameters on Solaris' do
      let(:facts) {{
        :osfamily        => 'Solaris',
      }}

      it { expect { should contain_package('telegraf') }.to raise_error(Puppet::Error, /Telegraf not supported/) }
    end
  end

  context 'telegraf configuration file parameters' do
    let(:params) {{ }}
    let(:facts) {{
      :osfamily => 'debian',
      :lsbdistid => 'ubuntu',
      :lsbdistcodename => 'trusty',
    }}

    it { is_expected.to contain_file('/etc/telegraf/telegraf.conf') }
    it { is_expected.to contain_file('/etc/telegraf/telegraf.d') }
  end
end
