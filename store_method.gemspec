Gem::Specification.new do |s|
  s.name        = "store_method"
  s.version     = "0.0.1"
  s.authors     = ["Vitaly Fomichov"]
  s.email       = ["fomichov@gmail.com"]
  s.homepage    = "https://github.com/fomichov/store_method"
  s.summary     = %q{Simple ActiveRecord extension to store calculated values in the corresponding database fields}
  s.description = %q{Simple ActiveRecord extension to store calculated values in the corresponding database fields}

  # s.rubyforge_project = "store_method"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", ['>= 3.0']
  s.add_development_dependency "bundler", ['>= 1.0.0', '<= 1.4']
  s.add_development_dependency 'rspec', ["= 3.1.0"]
  s.add_development_dependency "database_cleaner", "1.0.1"
  s.add_development_dependency "rake", ">= 0.9.2"
end
