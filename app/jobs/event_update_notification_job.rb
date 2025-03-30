# frozen_string_literal: true

class EventUpdateNotificationJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return unless event

    bookings = Booking.joins(:ticket).where(tickets: { event_id: event.id })

    bookings.each do |booking|
      BookingMailer.event_update_information(booking).deliver_now
    end
  end
end
