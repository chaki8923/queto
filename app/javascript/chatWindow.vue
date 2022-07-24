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
            $route: {params: { id: ""}},
            // id:this.$route.params.id
        };
    },
    methods: {
        getMessages() {
            const link = location.protocol + "//" + location.hostname + ":3000" + "/get_params";
            axios.get(link).then((res)=>{
                console.log(res);
                this.messages = res.data.content;
            });
        },
    },
    mounted() {
        console.log(this.$route);
     },
};
</script>
<template>
    <div>
       <router-link to="/users/15/rooms/3" name="ChatWindow">Home</router-link>
    </div>
</template>