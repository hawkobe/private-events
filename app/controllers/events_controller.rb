class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :can_modify?, only: [ :edit, :destroy ]
  before_action :find_params, except: [ :index, :new, :create ]
  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: "Post was successfully created"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to root_path, status: :see_other
  end

  def attend
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

  def can_modify?
    @event = Event.find(params[:id])

    unless current_user == @event.creator
      redirect_to root_path, alert: "You are not authorized to edit this"
    end
  end

  def find_params
    @event = Event.find(params[:id])
  end
end
