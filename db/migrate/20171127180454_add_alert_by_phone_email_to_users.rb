class AddAlertByPhoneEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_alert, :boolean
    add_column :users, :email_alert, :boolean
  end
end
