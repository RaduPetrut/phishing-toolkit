class AddTemplateIdColumnToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :template_id, :integer
  end
end
