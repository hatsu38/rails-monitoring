#!/bin/bash

cd /app

rm -f ./tmp/pids/server.pid

RAILS_ENV=${RAILS_ENV:-development} bundle exec rails server -b 0.0.0.0
