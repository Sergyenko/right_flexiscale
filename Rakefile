
require 'rubygems'
require 'hoe'
require "rake/testtask"
require 'rcov/rcovtask'
$: << File.dirname(__FILE__)
require 'lib/right_flexiscale.rb'

testglobs =     []

# Suppress Hoe's self-inclusion as a dependency for our Gem.  This also keeps
# Rake & rubyforge out of the dependency list.  Users must manually install
# these gems to run tests, etc.
# TRB 2/19/09: also do this for the extra_dev_deps array present in newer hoes.
# Older versions of RubyGems will try to install developer-dependencies as
# required runtime dependencies....
class Hoe
  def extra_deps
    @extra_deps.reject do |x|
      Array(x).first == 'hoe'
    end
  end
  def extra_dev_deps
    @extra_dev_deps.reject do |x|
      Array(x).first == 'hoe'
    end
  end
end

Hoe.new('right_flexiscale', RightFlexiscale::VERSION::STRING) do |p|
  p.rubyforge_name = 'rightscale'
  p.author = 'RightScale, Inc.'
  p.email = 'rubygems@rightscale.com'
  p.summary = 'Interface classes for the FlexiScale Web Services'
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = "/right_flexiscale_gem_doc"
  p.extra_deps = [['soap4r','>= 1.5.8']]
  p.test_globs = testglobs 
end

desc "Analyze code coverage of the unit tests."
Rcov::RcovTask.new do |t|
  t.test_files = FileList[testglobs]
  #t.verbose = true     # uncomment to see the executed command
end

# vim: syntax=Ruby
