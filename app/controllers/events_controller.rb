class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :invite]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :invite]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :authorize_invited_user!, only: [:show]

  def index
    @events = Event.where(private: false).or(Event.where(user: current_user))
    @past_events = @events.past
    @upcoming_events = @events.upcoming
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.new(event_params)
    if @event.save
      redirect_to events_path, notice: "Event created successfully!"
    else
      Rails.logger.debug @event.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event updated successfully!"
    else
      Rails.logger.debug @event.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      redirect_to events_path, notice: "Event deleted successfully!"
    else
      redirect_to events_path, alert: "Failed to delete the event."
    end
  end

  def invite
    user = User.find_by(id: params[:user_id])
    if user.nil?
      redirect_to @event, alert: "User not found"
    elsif @event.invited_users.include?(user)
      redirect_to @event, alert: "User has already been invited"
    else
      @event.invited_users << user
      redirect_to @event, notice: "User has been invited"
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    unless current_user == @event.user
      redirect_to events_path, alert: "Not authorized"
    end
  end

  def authorize_invited_user!
    unless @event.user == current_user || @event.invited_users.include?(current_user) || !@event.private
      redirect_to events_path, alert: "Not authorized to view this event"
    end
  end

  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :location, :description, :private)
  end
end
