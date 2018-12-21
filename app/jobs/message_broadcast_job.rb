class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    RoomChannel.broadcast_to(
      message.room_id,
      message: render_message(message),
      user_id: message.user_id
    )
  end

  private

  def render_message(message)
    MessagesController.render(
      partial: "messages/message",
      locals: { message: message }
    ) 
  end
end
