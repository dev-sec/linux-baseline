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

task :changelog do
  # Automatically generate a changelog for this project. Only loaded if
  # the necessary gem is installed. By default its picking up the version from
  # inspec.yml. You can override that behavior with `rake changelog to=1.2.0`
  begin
    require 'yaml'
    metadata = YAML.load_file('inspec.yml')
    v = ENV['to'] || metadata['version']
    puts " * Generating changelog for version #{v}"
    require 'github_changelog_generator/task'
    GitHubChangelogGenerator::RakeTask.new :changelog do |config|
      config.future_release = v
      config.user = 'dev-sec'
      config.project = 'linux-baseline'
    end
    Rake::Task[:changelog].execute
  rescue LoadError
    puts '>>>>> GitHub Changelog Generator not loaded, omitting tasks'
  end
end
