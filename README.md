# Holistic Testing Approach written mostly in Ruby, using Cucumber, Playwright and k6

This project showcases a holistic testing approach, leveraging mainly Ruby, Cucumber, Playwright for API and UI testing, along with JavaScript and k6 for performance tests. The demonstration site includes a REST API backend using [atsea-sample-shop-app](https://github.com/dockersamples/atsea-sample-shop-app/).

## Setup

You only need to have [docker](https://docs.docker.com/engine/install/) and [docker-compose](https://docs.docker.com/compose/install/) installed in your system

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

## Notes:
POM pattern is implemented for maintainability

## Current limitations:
I'm using an homemade gem to join the cucumber reports, it's currently an alpha, doesn't support for instance the **retry** flag