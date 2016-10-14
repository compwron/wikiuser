#!/usr/bin/env bash

echo "ruby version:"
ruby --version

echo "gemset:"
rvm gemset list

# this gem was built by me from the source https://github.com/compwron/wikipedia-vandalism-detection/commit/1a540566b9a115eb697a014d03f1f49fb30d9da9
rm -rf vendor/gems/*
gem unpack wikipedia-vandalism_detection-0.0.1.gem --target vendor/gems/

echo "bundle install"
bundle install

echo "checking that we're using the correct wikipedia-vandalism_detection"
bundle show wikipedia-vandalism_detection

echo "running the wikipedia-vandalism_detection import"
bundle exec ruby lib/go.rb
