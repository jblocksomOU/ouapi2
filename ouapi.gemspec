#http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/, http://guides.rubygems.org/make-your-own-gem/
#steps to build
#--gem build ouapi.gemspec
#--gem install oucampus

Gem::Specification.new do |s|
  
  s.name               = "ouapi2"
  s.version            = "0.0.0"
  s.date               = '2014-10-20'
  s.summary            = %q{ OUApi }
  s.description        = %q{ A wrapper for making calls to the OU Campus Api }
  s.authors            = ["jpoints@omniupdate.com"]
  s.email              = 'jpoints@omniupdate.com'
  s.files              =  Dir.glob("{bin,lib}/**/*")                    
  s.homepage           = 'http://www.justonpoints.com'
  s.default_executable = "ouapi"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
 # s.require_paths      = ["lib"]
  s.rubygems_version   = %q{1.6.2}
  s.add_dependency "json,rspec,zip"
  
end