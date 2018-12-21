function scrollToNewMessages(messages_container) {
  messages_container.animate({ scrollTop: messages_container.prop("scrollHeight")}, 500);
}

function registerRoomConnection(room_id) {
  App.room = App.cable.subscriptions.create(
    {
      channel: "RoomChannel",
      id: room_id
    },
    {
    connected: function() {
      return console.log("Connected to room #" + room_id);
    },
  
    disconnected: function() {},
  
    received: function(data) {
      $('#message_body').val('');
  
      let current_user_id = $('meta[name=current_user').data('id');
      let messages = $('#messages');
      let message = $($.parseHTML(data['message']));
  
      if (current_user_id !== undefined && current_user_id == data['user_id']) {
        message.addClass('current-user-message');
        message.find('.user-sender').text('You:')
      }
      messages.append(message);
      scrollToNewMessages(messages);
    },
    
    send_message: function(message, room_id) {
      return this.perform('send_message', {
        message: message,
        room_id: room_id
      });
    }
  });
}

$(document).ready(function() {
  let room_id = $('#messages').data('room-id');

  if (room_id !== undefined) {
    $('#new_message').on('submit', function (e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      
      let message_body = $('#message_body').val();
      
      App.room.send_message(message_body, room_id);
    });
    
    scrollToNewMessages($('#messages'));

    registerRoomConnection(room_id);
  }
  
});

