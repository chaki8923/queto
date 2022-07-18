import Vue from 'vue/dist/vue.esm'
import AvatarForm from '../avatarForm.vue'
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#avatar',
    render: h => h(AvatarForm, { props: $('#avatar').data() })
   }).$mount()

})