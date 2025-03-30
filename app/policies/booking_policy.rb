# frozen_string_literal: true

class BookingPolicy < ApplicationPolicy
  def create?
    authenticate_user?
  end

  private
    def authenticate_user?
      user.role_customer? && @record.user_id == user.id
    end
end
