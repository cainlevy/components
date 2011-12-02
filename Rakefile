require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the components gem.'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

desc 'Generate documentation for the components gem.'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "components"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end