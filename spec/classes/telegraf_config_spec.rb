require 'spec_helper'

describe 'telegraf::config', :type => :class do
  context 'supported configurations' do
    describe "telegraf class with pre_conditionals parameters on Ubuntu 14.04" do
      let(:params) {{ }}
      let(:facts) {{
        :osfamily => 'debian',
        :lsbdistid => 'ubuntu',
        :lsbdistcodename => 'trusty',
      }}
      let(:pre_condition) {
         'class{ "telegraf" :
             install_from_repository => true,
             config_base_file => "/etc/opt/telegraf/telegraf.conf"
          }'
      }

      it { should create_class('telegraf::config') }
    end
  end
end
