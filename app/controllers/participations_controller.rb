class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])

    participation = Participation.find_or_initialize_by(
      user: current_user,
      event: event
    )

    if participation.new_record?
      participation.save
      redirect_to event_path(event), notice: "参加しました！"
    else
      redirect_to event_path(event), alert: "すでに参加済みです"
    end
  end
end
