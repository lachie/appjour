require "date"
require "fileutils"
require "rubygems"
require "rake/gempackagetask"
require "spec/rake/spectask"

require "./lib/appjour/version.rb"

appjour_gemspec = Gem::Specification.new do |s|
  s.name             = "appjour"
  s.version          = Appjour::VERSION
  s.platform         = Gem::Platform::RUBY
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.rdoc"]
  s.summary          = "Announce an app over bonjour"
  s.description      = s.summary
  s.authors          = ["Lachie"]
  s.email            = "lachiec@gmail.com"
  s.homepage         = "http://github.com/lachie/appjour"
  s.require_path     = "lib"
  s.autorequire      = "appjour"
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.executables      = %w(appjour)
  
  s.add_dependency "dnssd", ">= 0.6.0"
end

Rake::GemPackageTask.new(appjour_gemspec) do |pkg|
  pkg.gem_spec = appjour_gemspec
end

namespace :gem do
  namespace :spec do
    desc "Update appjour.gemspec"
    task :generate do
      File.open("appjour.gemspec", "w") do |f|
        f.puts(appjour_gemspec.to_ruby)
      end
    end
    
    desc "test spec in github cleanroom"
    task :test do
      require 'rubygems/specification'
      data = File.read('appjour.gemspec')
      spec = nil
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
      puts spec
    end
  end
end

task :install => :package do
  sh %{sudo gem install pkg/appjour-#{Appjour::VERSION}}
end

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
  t.spec_opts = ["--options", "spec/spec.opts"]
end

task :default => :spec

desc "Remove all generated artifacts"
task :clean => :clobber_package