# frozen_string_literal: true

GEMS_DIR = "gems"

def gem_names
  Dir.glob("#{GEMS_DIR}/*/").map { |d| File.basename(d) }.sort
end

desc "Run bundle install"
task :setup do
  sh "bin/setup"
end

desc "Generate RBS files and run steep check for specified gem (or all gems)"
task :check, [:gem_name] do |_, args|
  gems = args[:gem_name] ? [args[:gem_name]] : gem_names
  gems.each { |gem_name| sh "bin/rbs_inline #{gem_name}" }
  if args[:gem_name]
    sh "bin/steep_check #{args[:gem_name]}"
  else
    sh "bin/steep_check"
  end
end

task default: :check
