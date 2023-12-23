#!/bin/sh
cd ./cucumber

#export base_uri='http://atsea:8080'
#export base_api_uri='http://atsea:8080/api'
#export browser='chrome'
#export rp_output_type='console_detailed'
#export PLAYWRIGHT_CLI_EXECUTABLE_PATH='~/../node_modules/.bin/playwright'
#export HOST_HAS_GUI=false

bundle install
rake run_parallel_regression
rake run_k6_load_test