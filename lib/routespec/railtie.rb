module Routespec
  class Railtie < Rails::Railtie
    rake_tasks do
      load "#{File.dirname(__FILE__)}/tasks/routespec.rake"
    end
  end
end
