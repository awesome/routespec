require 'fileutils'
require 'ostruct'
require 'yaml'
require 'erb'

module Routespec
  ##
  # Base Routespec error class
  class Error < RuntimeError
  end
end

require "routespec/builder"
require "routespec/dyr"
require "routespec/fyle"
require "routespec/parser"
require "routespec/template_vars"
require "routespec/tasks"
require "routespec/version"

# rails conditional requires
require "routespec/railtie" if defined? Rails
