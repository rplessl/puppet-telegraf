require 'spec_helper'

describe 'telegraf::init' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('telegraf') }
end
