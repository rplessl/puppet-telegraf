require 'spec_helper_acceptance'

describe 'telegraf class' do
  context 'default parameters' do
    it 'work without errors' do
      pp = <<-EOPC
      class { 'telegraf': }
      EOPC
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('telegraf') do
      it { is_expected.to be_installed }
    end

    describe service('telegraf') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
