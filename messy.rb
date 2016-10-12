def add_missing_dependency_to_gemfile
  result = `rm -rf Gemfile.lock ; bundle install ; ruby lib/foo.rb 2>&1`
  puts result
  # a = result.split("\n").find {|i| i.include?("Your bundle is locked to")}
  a = /.*locked to (.*)\, but.*/.match(result)
  if a
    gemname = a[1]
    b, c = gemname.split(" ")
    `echo "gem '#{b}', '#{c.gsub('(', '').gsub(')', '')}'" >> Gemfile`
  else
    weird_gemname = /.*Could not find (.*) in any.*/.match(result)[1]
    b, c = weird_gemname.reverse.split('-', 2).collect(&:reverse).reverse
    `echo "gem '#{b}', '#{c.gsub('(', '').gsub(')', '')}'" >> Gemfile`
  end
end
add_missing_dependency_to_gemfile()



