class Event < ApplicationRecord
  has_many :event_attendings, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendings, source: :attendee
  belongs_to :creator, class_name: "User"

  scope :past_events, -> { where("date < ?", Time.zone.now) }
  scope :upcoming_events, -> {  where("date > ?", Time.zone.now) }
end
