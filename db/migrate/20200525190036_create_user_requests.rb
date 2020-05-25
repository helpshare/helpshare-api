class CreateUserRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :user_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.datetime :finished_at, default: nil

      t.timestamps
    end
  end
end
