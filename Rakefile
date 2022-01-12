# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# lint the project
desc 'Run robocop linter'
task lint: [:rubocop]

# run tests
task default: [:lint, 'test:check']

namespace :test do
  # run inspec check to verify that the profile is properly configured
  task :check do
    require 'inspec'
    puts "Checking profile with InSpec Version: #{Inspec::VERSION}"
    profile = Inspec::Profile.for_target('.', backend: Inspec::Backend.create(Inspec::Config.mock))
    pp profile.check
  end
end
