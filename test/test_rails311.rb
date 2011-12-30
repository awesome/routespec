require 'test/unit'
require 'rubygems'
require 'bundler'
ENV['RAILS_ENV'] = 'test'
ENV['BUNDLE_GEMFILE'] = "#{File.dirname(__FILE__)}/rails311/Gemfile"
require "rails311/config/environment"
# routespec required in Gemfile
#require "routespec"

class TestRails311 < Test::Unit::TestCase
  def test_rails
    assert defined?(Rails)
    assert_equal "#{File.dirname(__FILE__)}/rails311", Rails.root.to_s
  end
end
