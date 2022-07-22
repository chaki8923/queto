import Vue from 'vue/dist/vue.esm'
import ChatWindow from  '../chatWindow.vue'
import router from './router' 
console.log('ルーター');
console.log(router);


document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    el: '#chat',
    render: h => h(ChatWindow)
   }).$mount()

})