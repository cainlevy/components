require File.dirname(__FILE__) + '/test_helper'

class ComponentsTest < Test::Unit::TestCase
  def test_component_response
    HelloWorldComponent.any_instance.expects(:say_it).returns("mukadoogle")
    assert_equal "mukadoogle", Components.render("hello_world/say_it", "gigglemuppit")
  end

  def test_rendering_a_component_view
    assert_equal "<b>pifferspangle</b>", Components.render("hello_world/say_it_with_style", "pifferspangle")
  end

  def test_implied_render_file
    assert_equal "<b>foofididdums</b>", Components.render("hello_world/bolded", "foofididdums")
  end

  def test_inherited_views
    assert_equal "parent/one", Components.render("parent/one")
    assert_equal "parent/two", Components.render("parent/two")
    assert_equal "child/one",  Components.render("child/one")
    assert_equal "parent/two", Components.render("child/two")
  end
end
