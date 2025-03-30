# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    authenticate_user?
  end

  def update?
    authenticate_user?
  end

  def destroy?
    authenticate_user?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  private
    def authenticate_user?
      user.role_event_organizer? && @record.user_id == user.id
    end
end
