class User < ApplicationRecord
  has_secure_password
  has_many :following
  has_many :alerts, through: :following

  validates :password, length: { minimum: 1 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, uniqueness: true
end
