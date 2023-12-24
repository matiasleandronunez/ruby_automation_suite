require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:run_regression) do |_t|
  _t.cucumber_opts = ""
end

task :run_parallel_regression do |_t|
  system "ruby -S bundle exec parallel_cucumber -n 4 -t cucumber --group-by scenarios -o \"--profile 'parallel' --publish-quiet\""
end

task :run_parallel_regression_with_retries do |_t|
  system "ruby -S bundle exec parallel_cucumber -n 4 -t cucumber --group-by scenarios -o \"--profile 'parallel' --publish-quiet --retry 2\""
end