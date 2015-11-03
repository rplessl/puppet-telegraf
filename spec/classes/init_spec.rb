require 'spec_helper'

describe 'telegraf::init' do
   let(:pre_condition){
      Package {
        provider => 'apt',
      }
    }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('telegraf') }
end
