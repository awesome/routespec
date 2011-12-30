require "test/unit"
require "routespec"

class TestFyle < Test::Unit::TestCase
  def setup
    @files = "#{File.dirname(__FILE__)}/files"
    @sandbox = "#{File.dirname(__FILE__)}/sandbox"
  end

#  def test_file_or_dir
#    flunk
#  end
#
#  def test_parse_file_name
#    flunk
#  end

  def test_spec_file_name
    assert_equal(Routespec::Fyle.spec_file_name(["beer", "is"], "awesome", "yes"), "yes/beer/is/awesome_spec.rb")
  end

  def test_hash_to_yaml_file
    hash = {2 => "Sao Gronca", 4 => "Ana Carolina"}
    file_name = "#{@sandbox}/seu_jorge.yml"
    FileUtils.rm_f(file_name)
    refute File.exist?(file_name)
    ret = Routespec::Fyle.hash_to_yaml_file(hash, file_name)
    assert_equal true, ret 
    assert_equal "--- \n2: Sao Gronca\n4: Ana Carolina\n", IO.read(file_name)
  end

  def test_hash_from_yaml_file
    hash = Routespec::Fyle.hash_from_yaml_file("#{@files}/awesome.yml") 
    assert hash.is_a?(Hash)
    assert_equal hash.first, [:awesome, "beer"] 
  end

  def test_string_to_file
    str = "awesome"
    file_name = "#{@sandbox}/awsome.txt"
    FileUtils.rm_f(file_name)
    refute File.exist?(file_name)
    ret = Routespec::Fyle.string_to_file(str, file_name)
    assert_equal true, ret
    assert File.exist?(file_name) 
    assert_equal "awesome", IO.read(file_name)
  end

  def test_array_to_file 
    array = %w[awesome rad cool dude] 
    file_name = "#{@sandbox}/cool.txt"
    FileUtils.rm_f(file_name) 
    refute File.exist?(file_name)
    ret = Routespec::Fyle.array_to_file(array, file_name)
    assert_equal true, ret
    assert File.exist?(file_name) 
    assert_equal "awesome\nrad\ncool\ndude\n", IO.read(file_name)
  end
end
