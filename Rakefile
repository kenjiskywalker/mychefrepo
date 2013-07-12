require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

attributes = YAML.load_file('attributes.yml')

desc "Run serverspec to all hosts"
task :default => 'serverspec:all'

namespace :serverspec do
  task :all => attributes.keys.map {|key| 'serverspec:' + key.split('.')[0] }
  attributes.keys.each do |key|
    desc "Run serverspec to #{key}"
    RSpec::Core::RakeTask.new(key.split('.')[0].to_sym) do |t|
      ENV['TARGET_HOST'] = key
      t.pattern = '{site-cookbooks, cookbooks}/{' + attributes[key][:roles].join(',') + '}/spec/*_spec.rb'
    end
  end
end
