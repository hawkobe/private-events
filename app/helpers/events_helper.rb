module EventsHelper
  def user_can_modify?(event)
    current_user == event.creator
  end

  def is_attending_guest?(event)
    event.attendees.include?(current_user) && current_user != event.creator
  end
end
