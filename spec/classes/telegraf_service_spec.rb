require 'spec_helper'

describe 'telegraf::service', :type => :class do

  it { should create_class('telegraf::service') }
  it { should contain_service('telegraf').with(
       'ensure' => 'running',
       'enable' => true
  ) }
end
