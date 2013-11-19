require 'mustache_test'

class TestContext < MustacheTest
  def test_template_name
    assert_equal "template_name", @view.render(:template => "template_name")
  end

  def test_view_helper_method
    assert_equal "<strong>Josh</strong>", @view.render(:template => "view_helper_method")
  end

  def test_render_partial_from_view
    assert_equal "Hello, Josh!", @view.render(:template => "view_helper_render_partial", :locals => { :name => "Josh" })
  end

  def test_view_class_method
    assert_equal "Hello, World!", @view.render(:template => "hello")
  end

  def test_local_shaddows_view_class_method
    assert_equal "Hello, Josh!", @view.render(:template => "hello", :locals => { :name => "Josh" })
  end

  def test_section_partial_pops_stack
    assert_equal "Hello, Josh!Hello, Chris!\n", @view.render(:template => "section_partial")
  end

  def test_has_people_object
    assert_equal "Hello, Joel!\n\n", @view.render(:template => 'has_people_object')
  end

  def test_render_nested_objects
    assert_equal "<h1>Category A</h1>\n<h2>Topic 1</h2>\n<h1>Category B</h1>\n",
      @view.render(:template => "nested")
  end

  def test_render_with_layout
    assert_equal "<!DOCTYPE html>\n<title>Hello</title>\nHello, World!\n",
      @view.render(:template => "hello", :layout => "application")
  end

  def test_delegates_view_helpers
    assert_equal "(<a href=\"x\">x</a>)\n", @view.render(:template => "delegates_view_helpers")
  end

  def test_delegates_view_helpers_on_partial_mustache
    assert_equal "(<a href=\"x\">x</a>)\n", @view.render(:template => 'delegates_view_helpers_on_partial_mustache')
  end

  def test_template_cache_key
    assert_equal "key:d9bfa3d9ed",
      @view.render(:template => "cache_key")
  end

  def test_lambda_section
    assert_equal "<p>  42\n</p>", @view.render(:template => "lambda_section")
  end
end
