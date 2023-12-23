require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'open3'

task :run_k6_stress_test do
  script_path = '../k6_scripts/stress_test_script.js'
  command = "k6 run #{script_path}"

  Open3.popen2e(command) do |stdin, stdout_err, wait_thr|
    # Read and print the output line by line
    stdout_err.each { |line| puts line }

    # Wait for the process to finish
    exit_status = wait_thr.value

    # Print the exit status
    puts "Exit Status: #{exit_status.exitstatus}"
  end
end
