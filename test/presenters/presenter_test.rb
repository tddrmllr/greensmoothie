require 'test_helper'

class PresenterTest < ViewTest
  attr_accessor :presenter, :presentable

  setup do
    @presenter = Presenter.new
  end

  test 'presenter should respond to view_context methods when the view_context is set' do
    presenter.view_context = OpenStruct.new(foo_method: 'foo')
    assert_equal 'foo', presenter.foo_method
  end

  test 'presnter should respond to presentable messages when the presentable is set' do
    presenter.presentable = OpenStruct.new(foo_method: 'foo')
    assert_equal 'foo', presenter.foo_method
  end
end
