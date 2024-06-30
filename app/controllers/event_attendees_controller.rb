class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    event_attendee = EventAttendee.new(event: event, user: current_user, checked_in: false)

    if event_attendee.save
      redirect_to event, notice: 'You are now attending this event'
    elsif EventAttendee.exists?(event: event, user: current_user)
      redirect_to event, alert: 'You are already attending this event'
    else
      logger.error "EventAttendee save failed: #{event_attendee.errors.full_messages.join(', ')}"
      redirect_to event, alert: 'Something went wrong: ' + event_attendee.errors.full_messages.join(', ')
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    event_attendee = EventAttendee.find_by(event: event, user: current_user)

    # Don't allow users to unattend past events
    if event.end_time < Time.now
      return redirect_to event, alert: 'You cannot unattend a past event'
    end

    if event_attendee
      event_attendee.destroy
      redirect_to event, notice: 'You are no longer attending this event'
    else
      redirect_to event, alert: 'You are not attending this event'
    end
  end
end
