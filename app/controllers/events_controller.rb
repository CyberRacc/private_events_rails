class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.new(event_params) # This line associates the event with the current_user

    if @event.save
      redirect_to events_path, notice: "Event created successfully!"
    else
      Rails.logger.debug @event.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :location, :description)
  end
end
