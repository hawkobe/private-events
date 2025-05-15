module EventsHelper
  def user_can_modify?(event)
    current_user == event.creator
  end
end
