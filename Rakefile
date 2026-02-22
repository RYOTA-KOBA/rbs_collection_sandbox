# frozen_string_literal: true

GEMS_DIR = 'gems'

def gem_names
  Dir.glob("#{GEMS_DIR}/*/").map { |d| File.basename(d) }.sort
end

desc 'Run RuboCop lint'
task :rubocop do
  sh 'bundle exec rubocop'
end

desc 'Generate RBS files and run steep check for specified gem (or all gems)'
task :check, [:gem_name] do |_, args|
  gems = args[:gem_name] ? [args[:gem_name]] : gem_names
  gems.each { |gem_name| sh "bin/rbs_inline #{gem_name}" }
  if args[:gem_name]
    sh "bin/steep_check #{args[:gem_name]}"
  else
    sh 'bin/steep_check'
  end
end

desc 'Verify that generated RBS files are committed and up-to-date'
task :diff, [:gem_name] do |_, args|
  gems = args[:gem_name] ? [args[:gem_name]] : gem_names
  gems.each { |gem_name| sh "bin/rbs_inline #{gem_name}" }
  diff_paths = gems.map { |gem_name| "#{GEMS_DIR}/#{gem_name}/sig/generated" }.join(' ')
  unless system("git diff --exit-code -- #{diff_paths}")
    gem_args = args[:gem_name] ? "[#{args[:gem_name]}]" : ''
    warn "\n❌ Generated RBS files are out of date. " \
         "Run `bundle exec rake check#{gem_args}` and commit the updated sig/generated files."
    exit 1
  end
  puts '✅ Generated RBS files are up-to-date.'
end

task default: :check
