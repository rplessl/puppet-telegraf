require 'spec_helper'

describe 'telegraf' do

  context 'testing supported operating systems' do

    describe "testing telegraf class without any parameters on RedHat" do
      let(:params) {{ }}
      let(:facts) {{
        :architecture              => 'amd64',
        :lsbdistid                 => 'RedHatEnterpriseServer',
        :lsbdistcodename           => 'Maipo',
        :operatingsystem           => 'redhat',
        :operatingsystemmajrelease => '7',
        :osfamily                  => 'redhat',
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

      it { is_expected.to contain_yumrepo('influxdata') }
    end

    describe "testing telegraf class without any parameters on Trusty" do
      let(:params) {{ }}
      let(:facts) {{
        :architecture              => 'amd64',
        :lsbdistid                 => 'ubuntu',
        :lsbdistcodename           => 'trusty',
        :operatingsystem           => 'debian',
        :operatingsystemmajrelease => '14.04',
        :osfamily                  => 'debian',
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

    describe "testing telegraf class without any parameters on Xenial" do
      let(:params) {{ }}
      let(:facts) {{
        :architecture              => 'amd64',
        :operatingsystemmajrelease => '16.04',
        :lsbdistcodename           => 'xenial',
        :lsbdistid                 => 'ubuntu',
        :operatingsystem           => 'debian',
        :osfamily                  => 'debian',
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

    describe "testing telegraf class without any parameters on raspbian jessie on raspi 2" do
      let(:params) {{ }}
      let(:facts) {{
        :architecture              => 'armv7l',
        :lsbdistid                 => 'raspbian',
        :lsbdistcodename           => 'jessie',
        :operatingsystem           => 'debian',
        :operatingsystemmajrelease => '8',
        :osfamily                  => 'debian',
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

  context 'testing installation on unsupported operating system' do
    describe 'telegraf class without any parameters on Solaris' do
      let(:facts) {{
        :operatingsystem => 'Solaris',
        :osfamily        => 'Solaris',
      }}

      it { expect { should contain_package('telegraf') }.to raise_error(Puppet::Error, /Telegraf not supported on Solaris/) }
    end
  end

  context 'testing telegraf configuration file parameters and installation directory' do
    let(:params) {{ }}
    let(:facts) {{
        :architecture              => 'amd64',
        :operatingsystemmajrelease => '14.04',
        :lsbdistid                 => 'ubuntu',
        :lsbdistcodename           => 'trusty',
        :operatingsystem           => 'debian',
        :osfamily                  => 'debian',
    }}

    it { is_expected.to contain_file('/etc/telegraf/telegraf.conf') }
    it { is_expected.to contain_file('/etc/telegraf/telegraf.d') }

    it { is_expected.to contain_file('/opt/telegraf').with_ensure('absent') }
  end

  context 'testing telegraf installation with apt on trusty' do
    let(:params) {{ }}
    let(:facts) {{
        :architecture              => 'amd64',
        :operatingsystemmajrelease => '14.04',
        :lsbdistcodename           => 'trusty',
        :lsbdistid                 => 'ubuntu',
        :operatingsystem           => 'debian',
        :osfamily                  => 'debian',
    }}

    describe 'testing apt repo dependenies first' do
        it { should contain_class('apt') }
        it { should contain_apt__source('influxdata').with(:release => 'trusty', :repos => 'stable', :location => 'https://repos.influxdata.com/debian') }
      end

      describe 'install dependencies first' do
        it { should contain_package('apt-transport-https').with_ensure('present').that_comes_before('Package[telegraf]') }
      end

      describe 'install the package' do
        it { should contain_package('telegraf').with_ensure('0.13.1') }
      end

  end
end
