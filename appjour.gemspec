Gem::Specification.new do |s|
  s.name = %q{appjour}
  s.version = "0.1.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lachie"]
  s.autorequire = %q{appjour}
  s.date = %q{2008-06-18}
  s.default_executable = %q{appjour}
  s.description = %q{Announce an app over bonjour}
  s.email = %q{lachiec@gmail.com}
  s.executables = ["appjour"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "bin/appjour", "lib/appjour", "lib/appjour/version.rb", "lib/appjour.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/lachie/appjour}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.0.1}
  s.summary = %q{Announce an app over bonjour}

  s.add_dependency(%q<dnssd>, [">= 0.6.0"])
end
