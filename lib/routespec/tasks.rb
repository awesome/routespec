module Routespec
  module Tasks
    class << self
      ##
      # output file should be "#{Rails.root}/spec/routespec/support/routes.txt"
      # pass Rails.root in dir_name arg
      def routes(dir_name, output_file_name)
        output = nil
        Dir.chdir(dir_name) do
          output = `rake routes`        
        end
        raise unless Dir.exist?(File.dirname(output_file_name))
        Routespec::Fyle.string_to_file(output, output_file_name) 
        return true
      end
    end
  end
end
