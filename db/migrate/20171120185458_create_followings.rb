class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: true
      t.string :coin_name

      t.timestamps
    end
  end
end
