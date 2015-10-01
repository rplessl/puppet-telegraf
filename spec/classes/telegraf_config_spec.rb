require 'spec_helper'

describe 'telegraf::config', :type => :class do

  let(:pre_condition) {
    'class{ "telegraf" :
      install_from_repository => true,
      config_file => "/etc/opt/telegraf/telegraf.conf"
    }'
  }

  it { is_expected.to contain_class('telegraf::config') }

end
