require 'test/unit'
require 'routespec'

class TestTasks < Test::Unit::TestCase
  def setup
    @file = File.dirname(__FILE__)
    @files = "#{@file}/files"
    @sandbox = "#{@file}/sandbox"
    @rails = "#{@file}/rails311"
  end

  def test_tasks_module
    assert defined? Routespec::Tasks
  end

  def test_routes
    file_name = "#{@sandbox}/routes.txt"
    exp_file_name = "#{@files}/tasks_routes.txt"
    FileUtils.rm_f(file_name)
    refute File.exist? file_name
    ret = Routespec::Tasks.routes(@rails, file_name)
    assert_equal true, ret
    assert File.exist? file_name
    assert_equal IO.read(exp_file_name), IO.read(file_name)
  end
end
