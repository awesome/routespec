module Routespec
  module Fyle 
    class << self
#      ##
#      # parses filetype path and name
#      def file_or_dir(string)
#        file_name = File.expand_path(string)
#        exist = File.exist?(file_name)
#        case  
#        when (exist && File.ftype(file_name) == "directory")
#          return {:ftype => "dir", :dir => File.path(string), :file => nil}
#        when (exist && File.ftype(file_name) == "file")
#          return {:ftype => "file", :dir => File.path(string), :file => File.basename(string)}
#        else
#          return {:ftype => "dir", :dir => File.path(__FILE__), :file => nil}
#        end
#      end
#
#      ##
#      # uses default name arg if one is not present in the file_name
#      def parse_file_name(file_name, def_name) 
#        hsh = file_or_dir(file_name)     
#        case hsh[:ftype]
#        when "dir"
#          return "#{hsh[:dir]}/#{def_name}" 
#        when "file"
#          return "#{hsh[:dir]}/#{hsh[:file]}" 
#        end
#      end

      ##
      # creates the "DIR/FILENAME_spec.rb" based on address (address derived from controller name)
      # takes array
      def spec_file_name(address, file_name = address.last, dir = nil)
        [dir, address.join("/"), "#{file_name}_spec.rb"].join("/")
      end

      ##
      # writes hash to yaml file
      def hash_to_yaml_file(hash, file_name)
        raise "file exists: #{file_name}" if File.exist?(file_name) 
        string_to_file(hash.to_yaml, file_name)
        return true
      end

      ##
      # returns hash of yaml
      def hash_from_yaml_file(file_name)
        raise "invalid file name: #{file_name}" unless File.exist?(file_name) 
        YAML.load_file(file_name)
      end

      ##
      # writes string to file
      def string_to_file(string, file_name, args = "w")
        File.open(file_name, args) {|f| f.write(string)} 
        return true
      end

      # takes lines in an array 
      # writes array to file, each indice is a line
      def array_to_file(lines_array, file_name, flags = "w")
        File.open(file_name, flags) do |file| 
          lines_array.each {|line|
            file.print("#{line}\n")
          }
        end
        return true
      end
    end
  end
end
