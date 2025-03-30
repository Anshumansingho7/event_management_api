# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  validates :name, :date, :address, :venue, presence: true
end
