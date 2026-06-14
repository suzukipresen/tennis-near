class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :event_date, presence: true
  validates :place, presence: true
  validates :description, presence: true

  validates :capacity,presence: true,numericality: { greater_than_or_equal_to: 1 }
  validates :fee,presence: true,numericality: { greater_than_or_equal_to: 0 }
  validates :level,presence: true,numericality: { greater_than_or_equal_to: 1,less_than_or_equal_to: 3}
  validate :event_date_cannot_be_in_the_past

  private

  def event_date_cannot_be_in_the_past
    return if event_date.blank?

    errors.add(:event_date, "は現在以降を指定してください") if event_date < Time.current
  end
end
