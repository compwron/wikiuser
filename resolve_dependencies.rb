class DependencyResolver
  COMMAND = "rm -rf Gemfile.lock ; bundle install ; ruby lib/foo.rb 2>&1"
  LOCKED_GEM = /.*locked to (.*)\, but.*/
  NOT_FOUND_GEM = /.*Could not find (.*) in any.*/
  ADD_GEM_TO_GEMFILE = 1

  def initialize
  end

  def run
    command_result = `#{COMMAND}`
    puts command_result
    if gem_result = _result_matches(command_result, LOCKED_GEM)
      p "FOUND unresolved gem"
      gem_name, gem_version = gem_result.split(' ')
      _add_gem_to_gemfile(gem_name, gem_version)
    elsif gem_result = _result_matches(command_result, NOT_FOUND_GEM)
      p "FOUND unfound gem"
      gem_name, gem_version = gem_result.reverse.split('-', 2).collect(&:reverse).reverse
      _add_gem_to_gemfile(gem_name, gem_version)
    end
    p "NOPE"
  end

  def _add_gem_to_gemfile(gem_name, gem_version)
    quoted_gem_name = "gem '#{gem_name}'"
    cleaned_gem_version = gem_version.gsub('(', '').gsub(')', '')
    quoted_cleaned_gem_version = "'#{cleaned_gem_version}'"
    cleaned_gem_declaration = [quoted_gem_name, quoted_cleaned_gem_version].join(", ")
    command = "echo \"#{cleaned_gem_declaration}\" >> Gemfile"
    p command
    `#{command}`
  end

  def _result_matches(output, regex)
    match_result = regex.match(output)
    match_result ? match_result[1] : nil
  end

end

p "RUNNING"
DependencyResolver.new.run
p "DONE"




