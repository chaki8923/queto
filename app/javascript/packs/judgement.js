import Vue from 'vue/dist/vue.esm'
import Judgement from '../judgement.vue'
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#judge',
    render: h => h(Judgement)
   }).$mount()

})