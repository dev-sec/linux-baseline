# encoding: utf-8

source 'https://rubygems.org'

# pin dependency for Ruby 1.9.3 since bundler is not
# detecting that net-ssh 3 does not work with 1.9.3
if Gem::Version.new(RUBY_VERSION) <= Gem::Version.new('1.9.3')
  gem 'net-ssh', '~> 2.9'
end

gem 'rake'
gem 'inspec', '~> 0'
gem 'rubocop', '~> 0.36.0'
gem 'highline', '~> 1.6.0'

group :tools do
  gem 'github_changelog_generator', '~> 1.12.0'
end
