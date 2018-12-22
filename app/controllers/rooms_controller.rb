class RoomsController < ApplicationController
  before_action :authenticate_user!, :ensure_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "Room successfully created!"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @room.update(room_params)
      flash[:notice] = "Room successfully updated!"
      redirect_to rooms_path
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    flash[:notice] = "#{@room.title} room successfully deleted!"
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit(:title, :hidden)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def ensure_admin
    unless current_user.admin?
      flash[:alert] = "This action available ony for admins!"
      redirect_to root_path
    end
  end

end