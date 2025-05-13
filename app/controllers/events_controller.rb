class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
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
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: "Post was successfully created"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def attend
    @event = Event.find(params[:id])
    if @event.attendees.include?(current_user)
      redirect_to @event, notice: "You are already on the list"
    else
      @event.attendees << current_user
      redirect_to @event, notice: "You have will now be attending #{@event.name.capitalize}!"
    end
  end

  private
  def event_params
    params.expect(event: [ :name, :location, :date ])
  end
end
