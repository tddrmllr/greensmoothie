require 'test_helper'

class MailchimpControllerTest < ControllerTest
  tests MailchimpController

  test 'successful subscribe' do
    Mailchimp::Subscribe.stub :run, true do
      xhr :post, :subscribe, email: 'bob@test.com', list_id: 'some_id'
      assert_equal "Thanks for signing up! We'll keep you up to date with the freshest green smoothie content.", flash[:success]
      assert_template 'layouts/flasher'
    end
  end

  test 'failed subscribe' do
    Mailchimp::Subscribe.stub :run, false do
      xhr :post, :subscribe, email: 'bob@test.com', list_id: 'some_id'
      assert_equal "Sorry, an error occurred.", flash[:error]
      assert_template 'layouts/flasher'
    end
  end
end
