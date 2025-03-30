# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[show update destroy]
      before_action :authorize_event, only: %i[show update destroy]

      def index
        authorize Event
        @events = policy_scope(Event.all, policy_scope_class: EventPolicy::Scope)
        render json: @events
      end

      def show
        render json: @event
      end

      def create
        @event = current_user.events.new(event_params)
        authorize @event

        if @event.save
          render json: @event, status: :created
        else
          render json: { error: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: { error: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @event.destroy
          render json: { message: "Event deleted successfully" }, status: :ok
        else
          render json: { error: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private
        def set_event
          @event = Event.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Event not found." }, status: :not_found
        end

        def authorize_event
          authorize @event, policy_class: EventPolicy
        end

        def event_params
          params.require(:event).permit(:name, :date, :venue, :address)
        end
    end
  end
end
