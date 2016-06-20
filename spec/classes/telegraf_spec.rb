require 'spec_helper'

describe 'telegraf' do

  context 'supported operating systems' do

    describe "testing telegraf class without any parameters on RedHat" do
      let(:params) {{ }}
      let(:facts) {{
        :operatingsystem => 'redhat',
        :osfamily => 'redhat',
      }}

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('telegraf::params') }
      it { is_expected.to contain_class('telegraf::install').that_comes_before('telegraf::config') }
      it { is_expected.to contain_class('telegraf::config') }
      it { is_expected.to contain_class('telegraf::service').that_subscribes_to('telegraf::config') }
      it { is_expected.to contain_class('telegraf::cleanup') }
      it { is_expected.to contain_class('telegraf::service').that_comes_before('telegraf::cleanup') }

      it { is_expected.to contain_service('telegraf') }
      it { is_expected.to contain_package('telegraf').with_ensure('0.13.1') }
      it { is_expected.to contain_class('telegraf') }
    end

   ['Trusty', 'Xenial'].each do |lsbdistcodename|
      describe "testing telegraf class without any parameters on #{lsbdistcodename}" do
        let(:params) {{ }}
        let(:facts) {{
          :lsbdistcodename => lsbdistcodename,
          :lsbdistid => 'ubuntu',
          :operatingsystem => 'debian',
          :osfamily => 'debian',
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('telegraf::params') }
        it { is_expected.to contain_class('telegraf::install').that_comes_before('telegraf::config') }
        it { is_expected.to contain_class('telegraf::config') }
        it { is_expected.to contain_class('telegraf::service').that_subscribes_to('telegraf::config') }
        it { is_expected.to contain_class('telegraf::cleanup') }
        it { is_expected.to contain_class('telegraf::service').that_comes_before('telegraf::cleanup') }

        it { is_expected.to contain_service('telegraf') }
        it { is_expected.to contain_package('telegraf').with_ensure('0.13.1') }
        it { is_expected.to contain_class('telegraf') }
      end
    end

    ['Jessie'].each do |lsbdistcodename|
      describe "testing telegraf class without any parameters on #{lsbdistcodename}" do
        let(:params) {{ }}
        let(:facts) {{
          :lsbdistcodename => lsbdistcodename,
          :lsbdistid => 'raspbian',
          :operatingsystem => 'debian',
          :osfamily => 'debian',
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('telegraf::params') }
        it { is_expected.to contain_class('telegraf::install').that_comes_before('telegraf::config') }
        it { is_expected.to contain_class('telegraf::config') }
        it { is_expected.to contain_class('telegraf::service').that_subscribes_to('telegraf::config') }
        it { is_expected.to contain_class('telegraf::cleanup') }
        it { is_expected.to contain_class('telegraf::service').that_comes_before('telegraf::cleanup') }

        it { is_expected.to contain_service('telegraf') }
        it { is_expected.to contain_package('telegraf').with_ensure('0.13.1') }
        it { is_expected.to contain_class('telegraf') }
      end
    end
  end

  context 'testing installation on unsupported operating system' do
    describe 'telegraf class without any parameters on Solaris' do
      let(:facts) {{
        :osfamily => 'Solaris',
        :operatingsystem => 'Solaris',
      }}

      it { expect { should contain_package('telegraf') }.to raise_error(Puppet::Error, /Telegraf not supported on Solaris/) }
    end
  end

  context 'testing telegraf configuration file parameters' do
    let(:params) {{ }}
    let(:facts) {{
      :osfamily => 'debian',
      :operatingsystem => 'debian',
      :lsbdistid => 'ubuntu',
      :lsbdistcodename => 'trusty',
    }}

    it { is_expected.to contain_file('/etc/telegraf/telegraf.conf') }
    it { is_expected.to contain_file('/etc/telegraf/telegraf.d') }
  end

  context 'testing telegraf installation directory' do
    let(:params) {{ }}
    let(:facts) {{
      :osfamily => 'debian',
      :operatingsystem => 'debian',
      :lsbdistid => 'ubuntu',
      :lsbdistcodename => 'trusty',
    }}

    it { is_expected.to contain_file('/opt/telegraf') }
  end
end
