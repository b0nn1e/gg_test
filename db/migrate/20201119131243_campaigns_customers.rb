class CampaignsCustomers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :campaigns, :customers do |t|
      t.index :campaign_id
      t.index :customer_id
    end
  end
end
