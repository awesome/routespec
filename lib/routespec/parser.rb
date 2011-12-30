module Routespec
  module Parser
    DEFAULT_HTTP_VERB = "GET"
    STATUS_CODES = {
      nil => 200,
      "GET" => 200,
      "PUT" => 200,
      "DELETE" => 200,
      "POST" => 201
    }

    #
    # turns this string:
    #  "agent_listing_gallery_photos GET    /agents/:agent_id/listings/:listing_id/galleries/:gallery_id/photos(.:format)       {:action=>\"index\", :controller=>\"agents_and_offices/photos\"}"
    # into:
    #  1. agent_listing_gallery_photos
    #  2. GET
    #  3. /agents/:agent_id/listings/:listing_id/galleries/:gallery_id/photos(.:format)
    #  4. {:action=> "index", :controller => "agents_and_offices/photos"}
    #
    #LINE_REGEX = /^\s*(\w+)?\s*(GET|PUT|POST|DELETE)?\s*(\/\S+){1}\s*(\{.+\})\s*$/
    LINE_REGEX = /^([^\/]*)(\/\S*){1}\s*(\{.+\})$/
    SYMBOL_REGEX = /:(\w+)\W/

    # :controller is found inside the hash
    VALIDATE_CONTROLLER_REGEX = /\{.*:controller.*\}/
    # :controller is found before the hash
    VALIDATE_DYNAMIC_CONTROLLER_REGEX = /:controller.*\{/

    class << self 

      ##
      # routes_text to lines_hash
      def parse(file_name = "#{File.dirname(__FILE__)}/test/files/rake_routes.txt")
        hash = routes_to_hash(file_name)
        lines_to_hash(hash[:lines])
      end

      ##
      # parses "rake routes" output in text file and returns hash of lines
      def routes_to_hash(file_name)
        hash = {:lines => {}, :lines_without_controller => {}}
        i = 0
        File.open(file_name).each_line{|x|
          case
          # validate pointing to controller
          when x =~ VALIDATE_CONTROLLER_REGEX
            hash[:lines][i+=1] = line_parse(x)
          when x =~ VALIDATE_DYNAMIC_CONTROLLER_REGEX
            hash[:lines][i+=1] = line_parse(x, {:address => ["dynamic"]})
          else
            hash[:lines_without_controller][i+=1] = x
          end
        } 
        #puts "routes parsed: #{i}"
        return hash
      end

      ##
      # creates new hash with nested address as keys; endpoints are turned into arrays; lines with matching addresses are appended to arrays
      # takes line_parse[:lines]
      def lines_to_hash(hash)
        new_hash = {}
        hash.each {|k,v|
          next unless v
          y = []
          key = ""
          v[:address].each {|x| 
            y << x
            key = y.map {|z| "[:#{z}]"}.join
            eval("new_hash#{key} ||= {}")
          }
          eval("new_hash#{key} = [] unless new_hash#{key}.is_a?(Array)") 
          eval("new_hash#{key} << #{v}") 
        }
        return new_hash
      end

      ##
      # splits nested controller names and returns array
      def address_parse(str)
        str ? str.split("/") : nil
      end

      ##
      # pulls out ":symbols" for each path and returns them in array
      # returns array of symbols in arg as string
      def path_parse(string)
        string.scan(/:(\w+)\W/).flatten
      end

      ##
      # creates variables array for erb test
      def variable_lines(array)
        array.map {|x| "#{x} = #{x == "format" ? "nil" : "\"REPLACE\""}"}
      end

      ##
      # creates a helper
      def helper_helper(helper_string, path_string, array)
        case  
        when helper_string
          if array.any? 
            return "#{helper_string}_path(#{array.map {|x| ":#{x} => #{x}"}.join(", ")})"
          else
            return "#{helper_string}_path"
          end
        when path_string 
          vars = path_string.scan(/:\w+/)
          vars << path_string.scan(/\*\w+/)
          vars.flatten.each {|x| path_string.sub!(x, "\#{#{x.delete(":").delete("*")}}")}
          return "\"#{path_string.gsub(/\(|\)/, "").sub(".", "\#{format ? \".\" : nil}")}\""
        end
      end

      ##
      # parses raw text line to hash
      def line_parse(string, options = {})   
        m = string.match(LINE_REGEX)
        helper = m[1].to_s.sub(/(GET|PUT|POST|DELETE)/, "").strip
        helper = helper.empty? ? nil : helper
        http_verb = Regexp.last_match ? Regexp.last_match[1] : DEFAULT_HTTP_VERB
        rhash = m[3] ? eval("#{m[3]}") : {}
        symbols = path_parse(m[2])

        hash = {
          :raw => string.strip.squeeze(" "),
          :helper => helper,
          :http_verb => http_verb, 
          :path => m[2],
          :action => rhash[:action],
          :controller => rhash[:controller],
          :symbols => symbols,
          :address => address_parse(rhash[:controller]), 
          :status_code => STATUS_CODES[http_verb],
          :helper_path => helper_helper(helper, m[2], symbols),
          :vars => variable_lines(symbols)
        }
        return hash.merge(options)
      end
    end
  end
end
