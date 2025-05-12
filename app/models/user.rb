class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  has_many :event_attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendings
  has_many :created_events, foreign_key: :creator_id, class_name: "Event"
end
