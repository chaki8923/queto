<script>
import axios from 'axios';
import router from './packs/router' 
//CSRFトークン生成
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;
export default {
    data() {
        return {
            messages:[],
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
        console.log(router.params);
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