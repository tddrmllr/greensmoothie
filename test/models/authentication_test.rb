require 'test_helper'

class AuthenticationTest < UnitTest
  test 'user' do
    authentication = authentications(:normal_user_facebook)
    assert_kind_of User, authentication.user
  end
end
