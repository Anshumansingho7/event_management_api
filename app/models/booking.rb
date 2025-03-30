class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validates :total_count, presence: true
end
