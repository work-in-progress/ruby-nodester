# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nodester/version"


Gem::Specification.new do |s|
  s.name        = "nodester"
  s.version     = Nodester::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Wawrusch"]
  s.email       = ["martin@wawrusch.com"]
  s.homepage    = "http://github.com/scottyapp/ruby-nodester"
  s.summary     = %q{An API wrapper for the nodester API (http://nodester.com).}
  s.description = %q{A gem that implements the nodester.com API which allows you to cloud-host node.js applications.}
  s.extra_rdoc_files   = ["LICENSE","README.md"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubyforge_project = "nodester"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency "httparty"  
  s.add_development_dependency "rspec", "~> 2.1"
  s.add_development_dependency "rake", "~> 0.8"
  s.add_development_dependency "fakeweb",">= 0"
  s.add_development_dependency "bundler","~> 1.0.0"
  #s.add_development_dependency "rcov", ">= 0"
  s.post_install_message=<<eos
**********************************************************************************
  Thank you for using this gem.
  
  Follow @martin_sunset on Twitter for announcements, updates and news
  https://twitter.com/martin_sunset

  To get the source go to http://github.com/scottyapp/ruby-nodester

**********************************************************************************    
eos
  
  
end
