class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.references :user, foreign_key: true
      t.decimal :price_above
      t.decimal :price_below
      t.string :state
      t.references :coin, foreign_key: true

      t.timestamps
    end
  end
end
