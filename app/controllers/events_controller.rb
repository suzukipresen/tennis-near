class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user!, only: [:edit, :update, :destroy]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: "募集を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: "募集を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, notice: "募集を削除しました"
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :event_date,
      :place,
      :level,
      :fee,
      :description,
      :capacity,
      :beginner_friendly
    )
  end

  private

  def correct_user!
    @event = Event.find(params[:id])

    redirect_to events_path, alert: "権限がありません" unless @event.user == current_user
  end

end
