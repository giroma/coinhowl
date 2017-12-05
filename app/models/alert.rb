class Alert < ApplicationRecord
  belongs_to :following

  validates :validate_at_least_one_field

  private
    def validate_at_least_one_field
      unless !price_above.blank? or !price_below.blank? or !percent.blank?
         record.errors[:base] << "Can't be blank"
      end
    end
end
