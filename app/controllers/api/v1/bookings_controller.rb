# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      before_action :set_ticket
      before_action :validate_booking_count, only: :create

      def create
        @booking = current_user.bookings.new(ticket: @ticket, total_count: booking_count)
        authorize @booking

        if @booking.save
          update_ticket_booking_count
          render json: @booking, status: :created
        else
          render_errors
        end
      end

      private
        def set_ticket
          @ticket = Ticket.find(params[:ticket_id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Ticket not found." }, status: :not_found
        end

        def booking_params
          params.require(:booking).permit(:total_count)
        end

        def booking_count
          @booking_count ||= booking_params[:total_count].to_i
        end

        def validate_booking_count
          return if booking_count.positive? && booking_count <= @ticket.availability

          render json: { error: "Only #{@ticket.availability} tickets are available" },
                 status: :unprocessable_entity
        end

        def update_ticket_booking_count
          @ticket.update!(total_booked: @ticket.total_booked + booking_count)
        end

        def render_errors
          render json: { error: @booking.errors.full_messages },
                 status: :unprocessable_entity
        end
    end
  end
end
