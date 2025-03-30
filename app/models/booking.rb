# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validates :total_count, presence: true
  after_create :schedule_confirmation_email
  attribute :total_price, :integer, default: 0
  attr_readonly :total_price

  def total_price
    ticket.price * total_count
  end

  private
    def schedule_confirmation_email
      TicketBookingConfirmationJob.set(wait: 2.minutes).perform_later(id)
    end
end
