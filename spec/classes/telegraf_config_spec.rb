require 'spec_helper'

describe 'telegraf::config', :type => :class do

  it { should create_class('telegraf::config') }

  context 'with default preset variables' do
    let(:pre_condition) {
      'class{ "telegraf" :
        install_from_repository => true,
        config_file => "/etc/opt/telegraf/telegraf.conf"
      }'
    }

  end
end
