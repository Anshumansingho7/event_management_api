# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  validates :name, :date, :address, :venue, presence: true
  after_update :schedule_event_update_email

  private
    def schedule_event_update_email
      EventUpdateNotificationJob.set(wait: 2.minutes).perform_later(id)
    end
end
