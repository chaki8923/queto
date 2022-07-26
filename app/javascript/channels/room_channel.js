import consumer from "./consumer"

console.log('room_channel.js読み込み');

window.addEventListener('load',(event) => {
  console.log('loadイベント読み込み');
  const data = document.getElementById("data");
  if (data === null) {
    console.log('dataなし');
    return
  }

  const room_id = data.getAttribute("data-id");
  const user_id = data.getAttribute("data-user-id");
  
  consumer.subscriptions.create(
    // "RoomChannel", 
  { channel: "RoomChannel", id: room_id, user_id: user_id },
  {
    connected() {
      // Called when the subscription is ready for use on the server

    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log('recieveした');
      console.log(data);
      document.getElementById("message_content").value = ''
      const container = document.getElementById("container")
      container.insertAdjacentHTML('beforeend', data['message'])
    }
  })
  });
