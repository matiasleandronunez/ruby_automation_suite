# Holistic Testing Approach written mostly in Ruby, using Cucumber, Playwright and k6

This project showcases a holistic testing approach, leveraging mainly Ruby, Cucumber, Playwright for API and UI testing, along with JavaScript and k6 for performance tests. The demonstration site includes a REST API backend using [atsea-sample-shop-app](https://github.com/dockersamples/atsea-sample-shop-app/).

## Setup
### Running in Docker

You only need to have [docker](https://docs.docker.com/engine/install/) and [docker-compose](https://docs.docker.com/compose/install/) installed in your system

Tear down and destroy older volumes if any
```bash
docker-compose down -v
```

To build and run the containers:

```bash
docker-compose up --build --force-recreate
```

Get the tests' container ID
```
docker ps
```
SSH into it
```
docker exec -it <cont_id> /bin/sh
```
Inside the container execute
```
./entrypoint.sh
```

Or try running rake tasks individually.
```
cd cucumber && rake run_regression
cd cucumber && rake run_parallel_regression
cd cucumber && rake run_parallel_regression_with_retries
```
```
cd cucumber && rake run_k6_load_test
cd cucumber && rake run_k6_soak_test
cd cucumber && rake run_k6_stress_test
cd cucumber && rake run_k6_spike_test
```

### Running from local env
To learn or play with the solution you might want to run the tests from your local environment. 
This will require you to install ruby, bundler, node, npm, playwright in whatever flavor is appropriate for your host system 
You'll still need docker-engine & docker-compose to boot the sample site up in order to target it:
```
docker-compose -f docker-compose-sample_site_only.yml up -d
```
And set up the following env vars, with the adequate value as per your system's configuration:
```
- BASE_API_URI=http://localhost:8080/api
- BASE_URI=http://localhost:8080/
- browser=chrome
- HOST_HAS_GUI=true
- PLAYWRIGHT_CLI_EXECUTABLE_PATH=~/node_modules/.bin/playwright
```
The following var can be set to specify report output if using the ParallelReportPortal::Cucumber::Formatter from gem 'parallel_report_portal'. Refer to 'https://github.com/matiasleandronunez/parallel_cucumber_reports.git', branch: 'feature/support_offline_reports' (WIP)
```
- rp_output_type=console_detailed
```
Execute `bundle install` and then you can run from command line using rake tasks same as within a docker container as described before.

## Rake Tasks:

- **run_regression**: Vanilla cucumber experience, sequential uses default formatter
- **run_parallel_regression**: Parallel Cucumber using parallel_tests gem and formatters set in cucumber.yml
- **run_parallel_regression_with_retries**: Parallel Cucumber using parallel_tests gem and formatters set in cucumber.yml, retries up to 2 times each test if first execution fails 
- **run_k6_load_test**: Runs a load performance test as scripted in load_test_script.js. 
- **run_k6_stress_test**: Runs a stress performance test as scripted in stress_test_script.js.
- **run_k6_spike_test**: Runs a spike performance test as scripted in spike_test_script.js.
- **run_k6_soak_test**:  Runs a soak performance test as scripted in soak_test_script.js.

## Notes:
POM pattern is implemented for maintainability

## Current limitations:
I'm using an homemade gem to join the cucumber reports, it's currently an alpha, doesn't support for instance the **retry** flag. This gem was originally meant to relay the test reports to report portal