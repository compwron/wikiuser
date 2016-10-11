result = `rm -rf Gemfile.lock ; bundle install ; ruby lib/foo.rb`
a = result.select {|i| i.include?("Your bundle is locked to")}
p a
# matches = /Your bundle is locked to (.*), but that version/.match(result)
