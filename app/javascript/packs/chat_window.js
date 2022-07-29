import Vue from 'vue/dist/vue.esm';
import router from './router';
import ChatWindow from  '../chatWindow.vue';
console.log(router);



document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#chat',
    router:router,
    render: h => h(ChatWindow)
   }).$mount()

})