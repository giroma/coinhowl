class User < ApplicationRecord
  has_secure_password
  has_many :following
  has_many :alerts, through: :following
end
