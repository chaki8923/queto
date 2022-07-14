import Vue from 'vue/dist/vue.esm'
import ImageUpload from '../imageUpload.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#avatar',
    render: h => h(ImageUpload)
   }).$mount()

})