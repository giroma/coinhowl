class AddPercentToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :percent, :decimal
  end
end
