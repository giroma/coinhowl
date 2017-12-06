class Alert < ApplicationRecord

  belongs_to :following

  validate :validate_at_least_one_field

  def validate_at_least_one_field
    if price_above.blank? && price_below.blank? && percent.blank?
      errors.add :base, "Can't be blank!"
    end
  end
end
