class Following < ApplicationRecord
  belongs_to :user
  has_many :alerts

  validates :user_id, :coin_name, presence: true
end
