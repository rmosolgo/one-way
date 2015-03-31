require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "spec" << "lib"
  t.pattern = "spec/**/*_spec.rb"
end

task(default: :test)

task :serve do
  require './spec/support/dummy_app'
  OneWay.serve
end
