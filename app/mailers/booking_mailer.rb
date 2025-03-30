# frozen_string_literal: true

class BookingMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: "Your Booking Confirmation")
  end

  def event_update_information(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: "Your Event update")
  end
end
