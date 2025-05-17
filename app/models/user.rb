class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true

  has_many :attended_events, through: :event_attendings
  has_many :event_attendings, foreign_key: :attendee_id
  has_many :created_events, foreign_key: :creator_id, class_name: "Event"

  has_many :invitations_received, through: :event_invitations
  has_many :event_invitations, foreign_key: :guest_invited_id
  has_many :invitations_sent, foreign_key: :host_inviting_id, class_name: "Event"
  # has_many :event_invitations, foreign_key: :host_inviting_id
end
