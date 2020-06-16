module Mailchimp
  class Subscribe
    attr_accessor :api, :email, :list_id

    def self.run(args = {})
      new(args).run
    end

    def initialize(args = {})
      @api = Mailchimp::API.new()
      @email = args[:email]
      @list_id = args[:list_id]
    end

    def run
      api.lists.subscribe(list_id, {email: email}, {}, {}, double_optin: false)
      true
    rescue Mailchimp::Error
      false
    end
  end
end
