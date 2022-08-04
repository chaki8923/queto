<script>
import axios from 'axios';


export default {
    data() {
        return {
            question: '',
            count: 0,
            second_id: '',
            oji_answer: 0
        };
    },
    methods: {
        axios_get(link) {
            axios.get(link).then((res) => {
                console.log(res.data.data);
                this.question = res.data.data
                console.log(this.question.id);
            });

        },
        getJudge($oji_count) {
            if(this.count == 2){
                const link = location.protocol + '//' + location.hostname + ':3000/get_judgement?id=' + this.question.id + '&id2=' + this.second_id + '&oji_answer=' + this.oji_answer;
                this.axios_get(link);

            }

            if (this.count == 1) {
                this.oji_answer = this.oji_answer + $oji_count;
                console.log(this.oji_answer);
                console.log('三番目');
                const link = location.protocol + '//' + location.hostname + ':3000/get_judgement?id=' + this.question.id + '&id2=' + this.second_id + '&oji_answer=' + this.oji_answer;
                this.axios_get(link);
                this.count = 2
            }
            else if (this.question) {
                console.log(this.oji_answer);
                console.log('二番目');
                this.oji_answer = this.oji_answer + $oji_count;
                const link = location.protocol + '//' + location.hostname + ':3000/get_judgement?id=' + this.question.id + '&oji_answer=' + this.oji_answer;
                this.axios_get(link);
                this.second_id = this.question.id;
                this.count = 1;

            } else {
                console.log('最初');
                this.oji_answer = this.oji_answer + $oji_count;
                const link = location.protocol + '//' + location.hostname + ':3000/get_judgement?oji_answer=' + this.oji_answer;
                this.axios_get(link);
            }

        },
        yes() {
            this.getJudge(1);
            const home_link = location.protocol + '//' + location.hostname + ':3000/home';
            if (this.count == 2) {
                // location.replace(home_link);
                // return
            }
        },
        no() {

            this.getJudge(0);
            const home_link = location.protocol + '//' + location.hostname + ':3000/home';
            if (this.count == 2) {

                location.replace(home_link);
                return
            }

        }
    },
    mounted() {
        this.getJudge(0);

    },

};


</script>
<template>
    <div class="container">
        <div class="question mt-5">
            <p>{{ question.title }}</p>
            <img :src="question.image" alt="">
        </div>
        <div class="btn_group">
            <button class="btn btn-primary" @click="yes">知ってる</button>
            <button class="btn btn-success ml-2" @click="no">知らない</button>
        </div>

    </div>
</template>