require 'test_helper'

class ApplicationHelperTest < HelperTest
  include ApplicationHelper

  attr_accessor :renderer

  test 'infinite_index' do
    infinite_index(OpenStruct.new(type: 'nutrient', search_terms: :name_cont, index: Nutrient.all))
    assert_equal 'shared/infinite_index', renderer.partial
  end

  test 'material_icon' do
    html = Nokogiri::HTML.fragment(material_icon('foo', class: 'bold', style: 'font-size: 20px')).children.first
    assert_includes html.attr('class'), 'zmdi zmdi-foo' # properly sets the icon library classes
    assert_includes html.attr('class'), 'bold' # properly sets custom classes
    assert_includes html.attr('style'), 'font-size: 20px' # properly sets the style attribute
  end

  test 'named_url_for' do
    resource = ingredients(:kale)
    assert_equal '/ingredients/kale', named_url_for(resource)
  end

  test 'title should return correct value if controller_name instance variable responds to title' do
    @foo = OpenStruct.new(title: 'Foo Title')
    assert_equal 'Foo Title', title
  end

  test 'should return @title instance variable if set and controller_name instance vairable not set' do
    @title = 'Foo Title'
    assert_equal 'Foo Title', title
  end

  test 'should return Green Smoothie if neither @title or controller_name instance variable is set' do
    assert_equal 'Green Smoothie', title
  end

  private

  def controller_name
    'foos'
  end

  def render(partial, options = {})
    @renderer = TestRenderer.new(partial, options)
  end

  class TestRenderer
    attr_accessor :partial, :options

    def initialize(partial = nil, options = {})
      @partial = partial
      @options = options
    end
  end
end
