echo "Deleting Gemfile.lock"
rm -rf Gemfile.lock
echo "bundle installing"
bundle install
echo "running import of "
ruby lib/foo.rb
