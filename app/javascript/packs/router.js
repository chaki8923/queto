
import Vue from 'vue'
import Router from 'vue-router'
import ChatWindow from  '../chatWindow.vue'

Vue.use(Router)
export default new Router({
  
    // modeのデフォルトは「hashモード」です。
    mode: 'history',
   
    // 1. hashモード
    // routes.rbの設定は不要です。
    
    // [URLの例]
    // http://localhost:3000/#/
    // http://localhost:3000/#/article/5
    // http://localhost:3000/#/article/33
    
    // 2. historyモード
    // routes.rbの設定が必要です。
    
    // [URLの例]
    // http://localhost:3000/
    // http://localhost:3000/article/5
    // http://localhost:3000/article/33
    
    // 3. abstractモード
    // 詳細は公式サイトへ https://router.vuejs.org/ja/api/#mode 

    
    // ルーターの設定
    routes: [
      {
        path: '/users/:user_id/rooms/:id',
        name: 'ChatWindow',
        
        // 同期でコンポーネントを呼び出す
        component: ChatWindow
      },
     
    ]
    
  })
