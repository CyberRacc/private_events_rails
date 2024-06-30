class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authorize_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def invitations
    @user = User.find(params[:id])
    @invited_events = @user.invited_events
  end

  def accept_invitation
    invitation = Invitation.find(params[:invitation_id])
    if invitation.user == current_user
      if invitation.update(status: 'accepted')
        event_attendee = EventAttendee.new(event: invitation.event, user: current_user, checked_in: false)
        if event_attendee.save
          Rails.logger.info "EventAttendee created successfully"
          redirect_to invitations_user_path(current_user), notice: "Invitation accepted."
        else
          Rails.logger.error "Failed to create EventAttendee: #{event_attendee.errors.full_messages.join(", ")}"
          redirect_to invitations_user_path(current_user), alert: "Failed to accept the invitation."
        end
      else
        redirect_to invitations_user_path(current_user), alert: "Failed to update invitation status."
      end
    else
      redirect_to invitations_user_path(current_user), alert: "You are not authorized to accept this invitation."
    end
  end

  def reject_invitation
    invitation = Invitation.find(params[:invitation_id])
    if invitation.user == current_user
      if invitation.update(status: 'rejected')
        redirect_to invitations_user_path(current_user), notice: "Invitation rejected."
      else
        redirect_to invitations_user_path(current_user), alert: "Failed to update invitation status."
      end
    else
      redirect_to invitations_user_path(current_user), alert: "You are not authorized to reject this invitation."
    end
  end

  private

  def authorize_user
    if current_user.id != params[:id].to_i
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
