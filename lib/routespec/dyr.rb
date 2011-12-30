module Routespec
  module Dyr
    LOCAL_ROUTESPEC_DIR = "#{File.dirname(__FILE__)}/routespec"
    class << self 
      ##
      # copies routespec dirs from gem to rails app
      def init(output_dir_name = "spec")
        unless Dir.exist?("#{output_dir_name}/routespec")
          Routespec::Dyr.create_dir(output_dir_name)
          FileUtils.cp_r(LOCAL_ROUTESPEC_DIR, output_dir_name)
          return true
        else
          return false
        end
      end

      ##
      # creates dirs from array
      def array_to_dirs(dir_name, array)
        array.each {|x| create_dir("#{dir_name}/#{x}")}
        return true
      end

      ##
      # checks if the dir exists based on the address and creates it (if it doesn't)
      def create_dir(dir_name) 
        Dir.exist?(dir_name) ? nil : Dir.mkdir(dir_name)
        return true
      end

      ##
      # checks if the dir exists based on the address and destroys it (if it does)
      def destroy_dir(dir_name)
        Dir.exist?(dir_name) ? (FileUtils.rm_rf dir_name) : nil
        return true
      end

      ##
      # creates nested dirs from address array
      def array_to_nested_dirs(array, root_dir)
        addr = [root_dir]
        array.each {|x|
          addr << x
          create_dir(addr.join("/"))
        }
        return true
      end
    end
  end
end
