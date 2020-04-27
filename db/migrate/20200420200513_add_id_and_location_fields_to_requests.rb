class AddIdAndLocationFieldsToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :outer_service_id, :string
    add_column :requests, :from_country, :string
    add_column :requests, :from_state, :string
    add_column :requests, :from_city, :string
    add_column :requests, :reception_type, :integer, default: 0, null: false
  end
end
