require 'test_helper'

module Support
  class MessagesControllerTest < ControllerTest
    tests MessagesController

    test 'successful create' do
      SupportMailer.stub :contact_form, ContactFormDouble.new do
        xhr :post, :create, email: 'bob@email.com', message: 'Help me please!'
        assert_equal "Your message was sent! We'll respond as soon as we can.", flash[:success]
      end
    end

    test 'failed create' do
      xhr :post, :create
      assert_equal "Please fill out all the fields.", flash[:error]
    end

    private

    class ContactFormDouble
      def deliver
        true
      end
    end
  end
end
