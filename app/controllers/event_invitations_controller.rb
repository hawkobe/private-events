class EventInvitationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @invitation = EventInvitation.new
  end

  def create
    @invitation = EventInvitation.new(invite_params)
    @event = Event.find(params[:event_id])
    @user = User.find(@invitation.guest_invited_id)

    if @invitation.valid?
      if @event.invited_guests.include?(@user)
        redirect_to @event, notice: "This guest has already been invited!"
      else
        @invitation.save
        redirect_to @event, notice: "Invitation sent!"
      end
    else
      render "new", alert: "Failed to send"
    end
  end

  private

  def invite_params
    params.expect(event_invitation: [ :guest_invited_id, :invited_event_id ])
  end
end
