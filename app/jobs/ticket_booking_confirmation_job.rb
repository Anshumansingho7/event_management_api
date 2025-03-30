# frozen_string_literal: true

class TicketBookingConfirmationJob < ApplicationJob
  queue_as :default

  def perform(id)
    booking = Booking.find_by(id: id)
    return unless booking

    BookingMailer.booking_confirmation(booking).deliver_now
  end
end
