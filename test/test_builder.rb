require "test/unit"
require "routespec"

class TestBuilder < Test::Unit::TestCase
  def setup
    @files = "#{File.dirname(__FILE__)}/files"
    @sandbox = "#{File.dirname(__FILE__)}/sandbox"
  end

  def test_text_to_yaml
    input_file_name = "#{@files}/routes.txt"
    output_file_name = "#{@sandbox}/routes.yml"
    FileUtils.rm_f(output_file_name)
    refute File.exist?(output_file_name)
    ret = Routespec::Builder.text_to_yaml(input_file_name, output_file_name) 
    assert_equal true, ret
    assert File.exist?(output_file_name)
    assert_equal IO.read("#{@files}/routes.yml"), IO.read(output_file_name)
  end

  def test_yaml_to_specs_with_dir_name
    dir_name = "#{@sandbox}/requests2" 
    input_file_name = "#{@files}/routes.yml"
    template_file_name = "#{@files}/response_code_vcr_spec.erb"
    FileUtils.rm_rf dir_name
    refute Dir.exist?(dir_name)
    ret = Routespec::Builder.yaml_to_specs(input_file_name, template_file_name, dir_name)
    assert_equal true, ret
    assert Dir.exist?(dir_name)
    exp_entries = [".", "..", "dynamic", "errors", "info_panel", "legacy"]
    assert_equal exp_entries, Dir.entries(dir_name)
  end
  
  def test_yaml_to_specs_without_dir_name
    input_file_name_orig = "#{@files}/routes.yml"
    input_file_name_temp = "#{@sandbox}/routes.yml" 
    template_file_name = "#{@files}/response_code_vcr_spec.erb"
    exp_dir_name = "#{@sandbox}/requests"
    assert File.exist?(input_file_name_orig)
    FileUtils.rm_rf input_file_name_temp
    refute File.exist?(input_file_name_temp)
    FileUtils.cp input_file_name_orig, input_file_name_temp
    assert File.exist?(input_file_name_temp)
    FileUtils.rm_rf exp_dir_name
    refute Dir.exist?(exp_dir_name)
    ret = Routespec::Builder.yaml_to_specs(input_file_name_temp, template_file_name)
    assert_equal true, ret
    assert Dir.exist?(exp_dir_name)
    exp_entries = [".", "..", "dynamic", "errors", "info_panel", "legacy"]
    assert_equal exp_entries, Dir.entries(exp_dir_name)
  end
  
  def test_hash_to_specs
    dir_name = "#{@sandbox}/cerveja"
    file_name_1 = "#{dir_name}/rad/rad_spec.rb"
    file_name_2 = "#{dir_name}/muito_legal/cool/cool_spec.rb"
    node_1 = {file_name_1 => {:address => ["rad"], :content => "skol"}}
    node_2 = {file_name_2 => {:address => ["muito_legal", "cool"], :content => "bavaria"}}
    hash = node_1.merge node_2
    FileUtils.rm_rf dir_name
    refute Dir.exist? dir_name 
    ret = Routespec::Builder.hash_to_specs(hash, dir_name)
    assert_equal true, ret
    assert File.exist? file_name_1
    assert File.exist? file_name_2
    assert Dir.exist? dir_name 
    assert Dir.exist? "#{dir_name}/rad" 
    assert Dir.exist? "#{dir_name}/muito_legal" 
    assert Dir.exist? "#{dir_name}/muito_legal/cool" 
    assert_equal "skol", IO.read(file_name_1)
    assert_equal "bavaria", IO.read(file_name_2)
  end

  def test_template_text
    template_file_name = "#{@files}/template_spec.erb"
    assert File.exist? template_file_name
    ret = Routespec::Builder.template_text(template_file_name)
    exp = "require \"spec_helper\"\n\n#\n# some text\n#\ndescribe \"<%= @name %>\" do\n  describe \"<%= @desc_1 %>\" do\n    it \"should have a <%= @desc_2 %>\" do\n      response.status.should be(<%= @response %>)\n    end\n  end\n\nend"
    assert_equal exp, ret 
  end

  def test_clean_lines
    file_name = "#{@files}/unclean.txt"
    file_text = IO.read file_name
    ret = Routespec::Builder.clean_lines(file_text) 
    assert_equal "dirty\n\ndirty\ndirty\n\ndirty\n\n\ndirty\n\ndirty", ret
  end

  def test_template_init
    hash = {:name => "homem", :desc_1 => "vai para a choperia", :desc_2 => "beer", :response => "\"awesome!\""}
    template_file_name = "#{@files}/template_spec.erb"
    assert File.exist? template_file_name
    ret = Routespec::Builder.template_init(hash, template_file_name)
    exp = "require \"spec_helper\"\n\n#\n# some text\n#\ndescribe \"homem\" do\n  describe \"vai para a choperia\" do\n    it \"should have a beer\" do\n      response.status.should be(\"awesome!\")\n    end\n  end\n\nend" 
    assert_equal exp, ret 
  end

  def test_array_to_objects
    array = [{:beer => "Bohemia"}, {:beer => "Skol"}, {:beer => "Brahma"}]
    ret = Routespec::Builder.array_to_objects(array)
    assert_kind_of Array, ret
    assert_kind_of OpenStruct, ret.first
    assert_equal "Bohemia", ret[0].beer
    assert_equal "Skol", ret[1].beer
    assert_equal "Brahma", ret[2].beer
  end

  def test_build
    template_file_name = "#{@files}/response_code_vcr_spec.erb"
    hash_file_name = "#{@files}/routes_hash_2.rb" 
    hash = eval("#{IO.read(hash_file_name)}") 
    assert_kind_of Hash, hash
    ret = Routespec::Builder.build(hash, hash.keys, template_file_name)
    assert_kind_of Hash, ret
    exp = IO.read("#{@files}/routes_hash_3.rb").sub(/\n$/, "")
    assert_equal exp, ret.to_s
  end
end
