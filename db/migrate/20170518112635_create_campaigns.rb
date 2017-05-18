class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :campaigns, [:user_id, :created_at]
  end
end
