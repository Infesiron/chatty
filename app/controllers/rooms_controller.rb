class RoomsController < ApplicationController
  before_action :authenticate_user!, :ensure_admin, only: [:edit, :update, :destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
      
  end

  def create

  end

  def show
    
  end

  def edit
    
  end

  def update

  end

  def destroy
    @room.destroy
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def ensure_admin
    unless current_user.admin?
      flash[:alert] = "This action available ony for admins"
      redirect_to root_path
    end
  end

end