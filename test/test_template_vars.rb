require "test/unit"
require "routespec"

class TestTemplateVars < Test::Unit::TestCase
  def test_template_class
    assert_kind_of Class, Routespec::TemplateVars
    assert Routespec::TemplateVars.new
  end

  def test_get_binding
    obj = Routespec::TemplateVars.new
    assert_kind_of Binding, obj.get_binding
    refute eval("@cool", obj.get_binding) 
    obj.instance_variable_set("@cool", "dude")
    act = eval("@cool", obj.get_binding)
    assert_equal "dude", act
  end
end
