# frozen_string_literal: true

class AddRegistartionTokenAndTimestampToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :registration_token, :string, limit: 256
    add_column :users, :registration_token_created_at, :datetime

    add_index :users, :registration_token, unique: true
  end
end
