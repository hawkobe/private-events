class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
    @events = Event.all
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

  private
  def event_params
    params.expect(event: [ :name, :location, :date ])
  end
end
