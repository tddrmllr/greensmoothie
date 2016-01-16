require 'test_helper'

class IngredientsHelperTest < HelperTest
  include ApplicationHelper

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
end
