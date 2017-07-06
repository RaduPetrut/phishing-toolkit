class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :campaign
      t.string :victim
      t.string :username
      t.string :password
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :reports, [:user_id, :created_at]
  end
end
