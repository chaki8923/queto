import consumer from "./consumer"


console.log('room_channel.js読み込み');

window.addEventListener('load',(event) => {
  console.log('loadイベント読み込み');
  const data = document.getElementById("data");
  if (data === null) {
    console.log('dataなし');
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

          console.log(user_id);
          console.log(data);
          
          document.getElementById("message_content").value = ''
          const container = document.getElementById("container")
        
          if(data.message_id == user_id){
              if(adult_flg == 'true'){//自分が発信者でおじさん
                const h = '<div class="chat-line my" >'  + data['message_young'] + '</div>'
                container.insertAdjacentHTML('beforeend', h)
                
              }else{//自分が発信者で若者
                console.log('young1');
                
                console.log('自分若者');
                console.log(adult_flg);
                const h = '<div class="chat-line my" >'  + data['message_old'] + '</div>'
                container.insertAdjacentHTML('beforeend', h)
              }
            }else{
              if(adult_flg == 'true'){//相手が発信者でおじさん
                
                const h = '<div class="chat-line you" >'  + data['message_young'] + '</div>'
                container.insertAdjacentHTML('beforeend', h)
              }else{//相手が発信者で若者
                console.log(adult_flg);
                console.log('こっちか？');
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
