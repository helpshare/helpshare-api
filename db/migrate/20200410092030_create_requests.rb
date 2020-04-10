class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :phone_number
      t.string :message_content

      t.timestamps
    end
  end
end
