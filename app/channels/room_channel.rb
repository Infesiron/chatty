class RoomChannel < ApplicationCable::Channel
  def subscribed
    # room = Room.find(params[:id])
    stream_from "room:#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create(
        body: data['message'],
        room_id: data['room_id']
      )
  end

  # def room
  #   Room.find(params[:id])
  # end
end
