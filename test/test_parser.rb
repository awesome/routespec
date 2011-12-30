require "test/unit"
require "routespec"

class TestParser < Test::Unit::TestCase
  def setup
    @files = "#{File.dirname(__FILE__)}/files"
    @routes_txt = "#{@files}/routes.txt" 
    text = IO.read("#{@files}/routes_hash.rb")
    eval("@routes_hash = #{text}") 
    text = IO.read("#{@files}/routes_hash_2.rb")
    eval("@routes_hash_2 = #{text}") 
  end

  def test_parse
    assert File.exist?(@routes_txt)
    ret = Routespec::Parser.parse(@routes_txt)
    assert_kind_of Hash, ret 
  end 

  def test_routes_to_hash
    assert File.exist?(@routes_txt)
    ret = Routespec::Parser.routes_to_hash(@routes_txt)
    assert_equal @routes_hash, ret
  end
  
  def test_lines_to_hash
    assert_equal @routes_hash_2, Routespec::Parser.lines_to_hash(@routes_hash[:lines])
  end
  
  def test_address_parse
    address = "agents_and_offices/photos"  
    assert_equal %w[agents_and_offices photos], Routespec::Parser.address_parse(address)
  end

  def test_path_parse
    path = "/agents/:agent_id/listings/:listing_id/galleries/:gallery_id/photos/:id(.:format)"  
    assert_equal %w[agent_id listing_id gallery_id id format], Routespec::Parser.path_parse(path)
  end
  
  def test_variable_lines
    array = %w[agent_id listing_id gallery_id id format] 
    array_2 = ["agent_id = \"REPLACE\"",
     "listing_id = \"REPLACE\"",
     "gallery_id = \"REPLACE\"",
     "id = \"REPLACE\"",
     "format = nil"]
    assert_equal array_2, Routespec::Parser.variable_lines(array) 
  end

  def test_helper_helper_with_helper_and_with_array
    helper_string = "awesome" 
    path_string = "awesome"
    array = %w[beer chips football]
    exp = "awesome_path(:beer => beer, :chips => chips, :football => football)"
    Routespec::Parser.helper_helper(helper_string, path_string, array) 
  end

  def test_helper_helper_with_helper_and_without_array
    helper_string = "awesome" 
    path_string = "awesome"
    array = []
    exp = "awesome_path(:beer => beer, :chips => chips, :football => football)"
    Routespec::Parser.helper_helper(helper_string, path_string, array)
  end

  def test_helper_helper_without_helper
    helper_string = nil
    path_string = "awesome/:beer/:chips/:football(.:format)"
    array = [] 
    exp = '/awesome/#{beer}/#{chips}/#{football}#{format ? "." : nil}#{format}'
    Routespec::Parser.helper_helper(helper_string, path_string, array) 
  end

  def test_line_parse
    @routes_hash[:lines].each {|k,v| 
      address = "[:#{v[:address].join("][:")}]"
      arr = nil
      eval "arr = @routes_hash_2#{address}"
      ret = Routespec::Parser.line_parse(v[:raw], ((v[:raw] =~ Routespec::Parser::VALIDATE_DYNAMIC_CONTROLLER_REGEX) ? {:address => ["dynamic"]} : {}))
      assert_kind_of Hash, ret 
      assert_includes arr, ret
    }
  end
end
