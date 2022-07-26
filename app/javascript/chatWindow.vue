<script>
import axios from 'axios';
import router from './packs/router'
import ActionCable from 'actioncable';
//CSRFトークン生成
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;
export default {
    data() {
        return {
            messages: [],
            $route: { params: { id: "" } },
            user_id: this.$route.params.user_id,
            room_id: this.$route.params.id
        };
    },
    methods: {
        getMessages() {
            const link = location.protocol + "//" + location.hostname + ":3000" + "/get_message/" + this.user_id + '/' + this.room_id;
            axios.get(link).then((res) => {
                console.log(res);
                this.messages = res.data;

            });
        },
    },
    mounted() {
        this.getMessages();
        const cable = ActionCable.createConsumer('ws://localhost:3000/cable')
        console.log(cable);
        this.messageChannel = cable.subscriptions.create('RoomChannel', {
            connected: () => {
                this.getMessages()
            },
            received: () => {
                this.getMessages()
            }
        })

    },
     beforeUnmount () { 
    this.messageChannel.unsubscribe()
  }
};
</script>
<template>
    <div>
        <ul v-for="message in messages">
            <li>{{ message.content }}</li>
        </ul>
    </div>

</template>