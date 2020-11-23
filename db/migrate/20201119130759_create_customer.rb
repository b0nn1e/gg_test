class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false, uniq: true, index: 'LOWER(email)'
      t.timestamps
    end
  end
end
