<script>
import axios from 'axios';

//CSRFトークン生成
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;
export default {
    data() {
        return {
            messages:[],
            id:this.$route.params.id
        };
    },
    methods: {
        getMessages() {
            const link = location.protocol + "//" + location.hostname + ":3000" + "/get_params";
            axios.get(link).then((res)=>{
                console.log(res);
                this.messages = res.data.content;
            })
        },
    },
    mounted() {
        console.log(this.id);
        
     },
};
</script>
<template>
    <div>
        
        <ul v-for="message in messages" key="message.id">
            <li>{{message.content}}</li>
        </ul>
    </div>
</template>