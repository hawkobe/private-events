class EventInvitation < ApplicationRecord
  belongs_to :invited_event, class_name: "Event"
  belongs_to :guest_invited, class_name: "User"
end
