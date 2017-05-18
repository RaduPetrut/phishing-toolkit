class AddMissingColumnsToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :smtp_server, :string
    add_column :campaigns, :from, :string
    add_column :campaigns, :from_alias, :string
    add_column :campaigns, :subject, :string
  end
end
