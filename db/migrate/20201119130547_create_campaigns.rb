class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.string :subject, null: false
      t.string :message, null: false
      t.timestamps
    end
  end
end
