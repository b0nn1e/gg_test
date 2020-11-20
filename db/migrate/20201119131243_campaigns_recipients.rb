class CampaignsRecipients < ActiveRecord::Migration[6.0]
  def change
    create_join_table :campaigns, :recipients do |t|
      t.index :campaign_id
      t.index :recipient_id
    end
  end
end
