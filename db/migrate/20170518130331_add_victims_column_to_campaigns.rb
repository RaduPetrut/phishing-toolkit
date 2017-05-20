class AddVictimsColumnToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :victims, :text
  end
end
