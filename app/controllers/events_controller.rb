class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event updated successfully!"
    else
      Rails.logger.debug @event.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, notice: "Event deleted successfully!"
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :location, :description)
  end
end
