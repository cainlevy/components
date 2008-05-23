require File.dirname(__FILE__) + '/test_helper'

class CachingTest < Test::Unit::TestCase
  def setup
    ActionController::Base.stubs(:cache_configured?).returns(true)
    klass = HelloWorldComponent.dup
    klass.stubs(:path).returns("hello_world")
    klass.send(:cache, :say_it)
    @component = klass.new
  end

  def test_cache_method_chaining
    @component.expects(:with_caching).with(:say_it, ["janadumplet"]).returns("janadoomplet")
    assert_equal "janadoomplet", @component.say_it("janadumplet")
  end

  def test_cache_key_generation
    assert_equal "hello_world/say_it", @component.send(:cache_key, :say_it), "simplest cache key"
    assert_equal "hello_world/say_it/trumpapum", @component.send(:cache_key, :say_it, ["trumpapum"]), "uses arguments"
    assert_equal "hello_world/say_it/a/1/2/3/foo=bar", @component.send(:cache_key, :say_it, ["a", [1,2,3], {:foo => :bar}]), "handles mixed types"
    assert_equal "hello_world/say_it/a=1&b=2", @component.send(:cache_key, :say_it, [{:b => 2, :a => 1}]), "hash keys are ordered"
  end

  def test_cache_hit
    @component.expects(:read_fragment).with("hello_world/say_it/loudly").returns("LOUDLY!")
    @component.expects(:say_it_without_caching).never
    @component.say_it("loudly")
  end

  def test_cache_miss
    @component.expects(:read_fragment).returns(nil)
    @component.expects(:write_fragment).with("hello_world/say_it/frumpamumpa", "frumpamumpa")
    assert_equal "frumpamumpa", @component.say_it("frumpamumpa")
  end
end