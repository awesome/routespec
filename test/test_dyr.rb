require "test/unit"
require "routespec"

class TestDyr < Test::Unit::TestCase
  def setup
    @sandbox = "#{File.dirname(__FILE__)}/sandbox"
    @root_dir = "#{@sandbox}/root"
    @requests = "#{@sandbox}/requests"
    [@sandbox, @root_dir, @requests].each {|x| Dir.mkdir(x) unless Dir.exist?(x)}
  end

  def test_array_to_dirs
    array = %w[lion leopard tiger]
    array.each {|x| Dir.rmdir("#{@root_dir}/#{x}") if Dir.exist?("#{@root_dir}/#{x}")}
    ret = Routespec::Dyr.array_to_dirs(@root_dir, array)
    assert_equal true, ret
    assert_equal (array + %w[. ..]).sort, Dir.entries(@root_dir).sort
  end

  def test_create_dir
    example_dir = "#{@sandbox}/case_o_beer"   
    FileUtils.rm_rf(example_dir) if Dir.exist?(example_dir)
    refute Dir.exist?(example_dir)
    ret = Routespec::Dyr.create_dir(example_dir)
    assert_equal true, ret
    assert Dir.exist?(example_dir)
  end

  def test_destroy_dir
    example_dir = "#{@sandbox}/jack_o_lantern"   
    Dir.mkdir(example_dir) unless Dir.exist?(example_dir)
    assert Dir.exist?(example_dir)
    ret = Routespec::Dyr.destroy_dir(example_dir)
    assert_equal true, ret
    refute Dir.exist?(example_dir)
  end

  def test_array_to_nested_dirs
    FileUtils.rm_rf "#{@requests}/testing"
    array = %w[testing testing one two three]
    ret = Routespec::Dyr.array_to_nested_dirs(array, @requests)
    assert_equal true, ret
    assert(Dir.exist?("#{@requests}/testing/testing/one/two/three"))
  end

  def test_init
    output_dir_name = "#{@sandbox}/rails_root"
    FileUtils.rm_rf output_dir_name
    refute Dir.exist? output_dir_name
    Dir.mkdir output_dir_name
    assert Dir.exist? output_dir_name
    ret =  Routespec::Dyr.init(output_dir_name)
    assert_equal true, ret
    assert_equal [".", "..", "routespec"], Dir.entries(output_dir_name)
  end
end
