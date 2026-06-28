class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user!, only: [:edit, :update, :destroy]
  def index
    p params
    @events = Event.all

    # 日付
    if params[:date].present?
      date = Date.parse(params[:date])
      @events = @events.where(event_date: date.beginning_of_day..date.end_of_day)
    end
    # level
    if params[:level].present?
      @events = @events.where(level: params[:level])
    end
    # 初心者歓迎
    if params[:beginner_friendly] == "1"
      @events = @events.where(beginner_friendly: true)
    end
    # 場所
    if params[:place].present?
      @events = @events.where("place LIKE ?", "%#{params[:place]}%")
    end

    @markers = @events.map do |event|
      {lat: event.latitude,lng: event.longitude,title: event.title}
end
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
