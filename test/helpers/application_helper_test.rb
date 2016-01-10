require 'test_helper'

class IngredientsHelperTest < HelperTest
  include ApplicationHelper

  test 'named_url_for' do
    resource = ingredients(:kale)
    assert_equal '/ingredients/kale', named_url_for(resource)
  end
end
