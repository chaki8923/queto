
import Vue from 'vue'
import Router from 'vue-router'
import ChatWindow from  '../chatWindow.vue'

Vue.use(Router)

const router = new Router({
    mode: 'history',
    routes: [
        {
          path: '/users/:user_id/rooms/:id',
          name: 'ChatWindow',
          
          // 同期でコンポーネントを呼び出す
          component: ChatWindow
        },
      ]   
})
export default router