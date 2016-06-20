source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem 'metadata-json-lint'
  gem "puppet-lint"
  gem "rspec-puppet"
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "beaker", '2.33.0'
  gem "beaker-rspec"
  gem "puppet-blacksmith"
  gem "guard-rake"
  gem "listen", "~> 3.0.0"
end
