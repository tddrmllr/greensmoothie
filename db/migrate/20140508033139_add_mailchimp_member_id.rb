class AddMailchimpMemberId < ActiveRecord::Migration
  def change
    add_column :users, :mailchimp_member_id, :string
  end
end
