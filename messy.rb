require 'pry'
def magic
  result = `rm -rf Gemfile.lock ; bundle install ; ruby lib/foo.rb 2>&1`
  puts result
  a = result.split("\n").find {|i| i.include?("Your bundle is locked to")}
  gemname = /.*locked to (.*)\, but.*/.match(a)[1]
  puts gemname
  b, c = gemname.split(" ")
  `echo "gem '#{b}', '#{c.gsub('(', '').gsub(')', '')}'" >> Gemfile`
end
magic()



