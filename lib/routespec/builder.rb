module Routespec
  module Builder
    class << self
    
      ##
      # takes routes.txt and creates routes.yml
      # if not specifying filename, will put routes.yml in same dir as routes.txt
      def text_to_yaml(routes_txt, file_name = nil)
        raise unless File.exist?(routes_txt)
        unless file_name
          file_name = "#{Dir.path(routes_txt)}/routes.yml" 
        end

        hash = Routespec::Parser.parse(routes_txt)
        Routespec::Fyle.hash_to_yaml_file(hash, file_name)
        return true
      end

      ##
      # writes routes.yml to multiple spec files 
      # if not specifying dir, will put specs in "requests" in same dir as routes.yml
      def yaml_to_specs(routes_yml, template_name, dir_name = nil)
        raise unless File.exist?(routes_yml)
        unless dir_name
          path_name = File.dirname(routes_yml) 
          dir_name = "#{path_name}/requests"
        end
        Routespec::Dyr.create_dir(dir_name)

        hash = Routespec::Fyle.hash_from_yaml_file(routes_yml)
        hash = Routespec::Builder.build(hash, hash.keys, template_name)
        hash_to_specs(hash, dir_name)
        return true
      end

      ##
      # writes hash built from lines to mulitple spec files
      def hash_to_specs(hash, output_dir = nil)
        hash.each {|k,v| 
          Routespec::Dyr.create_dir(output_dir) if output_dir
          Routespec::Dyr.array_to_nested_dirs(v[:address], output_dir) 
          file_name = k.sub(/^#{output_dir}/, "")
          #Routespec::Fyle.string_to_file(v[:content], k)
          #Routespec::Fyle.string_to_file(v[:content], "#{output_dir}/#{k}")
          Routespec::Fyle.string_to_file(v[:content], "#{output_dir}/#{file_name}")
        }
        return true
      end

      ##
      # reads erb template to string
      # "we quote the template literally with %q{...} to avoid trouble with the backslash."--http://www.ruby-doc.org/stdlib-1.9.3/libdoc/erb/rdoc/ERB.html
      def template_text(template_file_name)
        str = IO.read(template_file_name)
        str = clean_lines(str)
        return eval("%q{#{str}}")
      end

      ##
      # remove trailing whitespace to make clean for trim_mode in erb
      def clean_lines(text)
        text.split(/\n/).map {|x| x =~ /^\s*<%[^=]/ ? x.strip : x.rstrip}.join("\n").chomp
      end

      ##
      # creates string with erb template and variables 
      def template_init(hsh, template_file_name)
        tmp_vars = Routespec::TemplateVars.new
        hsh.each {|k,v|
          tmp_vars.instance_variable_set("@#{k}", v) 
        }
        template = ERB.new(template_text(template_file_name), 0, "%<>")
        # needed because erb's trim_mode usage isn't understood yet
        #return str.gsub(/^\s*$\n/, "")
        # now working, need to clean line endings with Ruby#chomp for trim_mode to work
        return template.result(tmp_vars.get_binding)
      end

      ##
      # creates objects from array
      # takes array of hashes
      def array_to_objects(array)
        array.map {|x| OpenStruct.new(x)}
      end
      
      ##
      # recursive itteration over hash to turn built hash from lines to hash with erb template strings using file_names as keys
      # returns hash
      def build(hash, keys, template_name)
        new_hash = {}
        while !keys.empty?
          key = keys.shift 
          val = hash[key]
          case 
          when val.is_a?(Hash)
            self.build(val, val.keys, template_name)
          when val.is_a?(Array)
            address = val.first[:address]
            str = template_init({:routes => array_to_objects(val), :name => address.last}, template_name)
            new_hash[Routespec::Fyle.spec_file_name(address)] = {:content => str, :address => address}
          end
        end
        return new_hash
      end
      
      ##
      #

    end
  end
end
