#!/usr/bin/env rake
require 'hoe'

# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
# Hoe.plugin :racc
# Hoe.plugin :rubyforge

#Hoe.spec 'routespec' do
#  # HEY! If you fill these out in ~/.hoe_template/Rakefile.erb then
#  # you'll never have to touch them again!
#  # (delete this comment too, of course)
#
#  # developer('FIX', 'FIX@example.com')
#
#  # self.rubyforge_name = 'routespecx' # if different than 'routespec'
#end

desc "builds and installs routespec gem locally from gemspec"
task :build_and_install do 
  Dir.chdir(File.dirname(__FILE__)) do
    `gem build routespec.gemspec`
    `gem install routespec` 
  end
end
