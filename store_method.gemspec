Gem::Specification.new do |s|
  s.name        = "store_method"
  s.version     = "0.0.1"
  s.authors     = ["Vitaly Fomichov"]
  s.email       = ["fomichov@gmail.com"]
  s.homepage    = "https://github.com/fomichov/store_method"
  s.summary     = %q{store calculated values in the corresponding database fields}
  s.description = %q{Like alias_method, but it's store_method!}

  # s.rubyforge_project = "store_method"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  
  if RUBY_VERSION >= '1.9'
    s.add_development_dependency 'minitest-reporters'
  end
end
