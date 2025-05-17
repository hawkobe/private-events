class EventInvitationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @invitation = EventInvitation.new
  end

  def create
    @invitation = EventInvitation.new(invite_params)

    if @invitation.save
      redirect_to root_path, notice: "Invitation sent!"
    else
      debugger
      render "new", alert: "Failed to send"
    end
  end

  private

  def invite_params
    params.expect(event_invitation: [ :guest_invited_id, :invited_event_id ])
  end
end
