# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  validates :name, :date, :address, :venue, presence: true
end
