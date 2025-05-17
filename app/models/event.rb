class Event < ApplicationRecord
  has_many :event_attendings, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendings, source: :attendee
  belongs_to :creator, class_name: "User"

  has_many :event_invitations, foreign_key: :invited_event_id
  has_many :invited_guests, through: :event_invitations, source: :guest_invited

  scope :past_events, -> { where("date < ?", Time.zone.now) }
  scope :upcoming_events, -> {  where("date > ?", Time.zone.now) }
end
