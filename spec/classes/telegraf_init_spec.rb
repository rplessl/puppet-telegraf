require 'spec_helper'

describe 'telegraf', :type => 'class' do

  it { should contain_class('telegraf::params') }
  it { should create_class('telegraf') }

end
