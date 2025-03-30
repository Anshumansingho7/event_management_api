# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy
  validates :price, :ticket_count, :total_booked, presence: true
  attribute :availability, :integer, default: 0
  attr_readonly :availability

  def availability
    ticket_count - total_booked
  end
end
