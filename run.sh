echo "Deleting Gemfile.lock"
rm -rf Gemfile.lock
bundle install
ruby lib/foo.rb
