import Vue from 'vue/dist/vue.esm'
import ChatWindow from  '../chatWindow.vue'
import router from './router' 
console.log('ルーター');
console.log(router);


document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#chat',
    router:router,
    render: h => h(ChatWindow)
   }).$mount()

})