import consumer from "./consumer"

window.addEventListener('load',(event) => {

  const data = document.getElementById("data");
  if (data === null) {
    return
  }
  if(data !== null){
    
    const room_id = data.getAttribute("data-id");
    const user_id = data.getAttribute("data-user-id");
    const adult_flg = data.getAttribute("data-adult-flg");
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
        //部屋一覧画面居る時にリクエスト許可されれば自動リロード
          if(data.request_id == user_id){
            location.reload();
            return;
          }
          
          document.getElementById("message_content").value = ''
          const container = document.getElementById("container")
          
          if(data.message_id == user_id){
              if(adult_flg == 'true'){//自分が発信者でおじさん
                const h = '<div class="chat-line my" >'  + data['message_young'] + '</div>'
                container.insertAdjacentHTML('beforeend', h)
                
              }else{//自分が発信者で若者
                const h = '<div class="chat-line my" >'  + data['message_old'] + '</div>'
                container.insertAdjacentHTML('beforeend', h)
              }
            }else{
              if(adult_flg == 'true'){//相手が発信者でおじさん
                
                const h = '<div class="chat-line you" >'  + data['message_young'] + '</div>'
                container.insertAdjacentHTML('beforeend', h)
              }else{//相手が発信者で若者

              const h = '<div class="chat-line you" >'  + data['message_old'] + '</div>'
              container.insertAdjacentHTML('beforeend', h)
            }
            
          }
          var obj = document.getElementById('container');
          obj.scrollTop = obj.scrollHeight;
      }
    })
  }

  });
