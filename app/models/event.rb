class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :event_date, presence: true
  validates :place, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :fee, presence: true
end
