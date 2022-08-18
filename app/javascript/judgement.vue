<script>
import axios from "axios";
//CSRFトークン生成
const token = document
  .getElementsByName("csrf-token")[0]
  .getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

export default {
  data() {
    return {
      question: "",
      count: 0,
      second_id: "",
      oji_answer: 0,
      processing: false,
    };
  },
  methods: {
    axios_get(link) {
      axios.get(link).then((res) => {
        this.question = res.data.data;
        this.processing = false
      });
        
    },
    axios_post(link) {
      axios
        .post(link)
        .then((res) => {})
        .catch(function (err) {
          console.log(err);
        });
    },
    getJudge($oji_count) {
      if (this.count == 2) {
        console.log("３回答");
        this.oji_answer = this.oji_answer + $oji_count;
        if (this.oji_answer >= 2) {
          console.log("oji 処理");
          // const link = location.protocol + "//" + location.hostname + ":3000/create_judgement?oji=" + 1;
          const link = location.protocol + "//" + location.hostname + "/create_judgement?oji=" + 1;
          this.axios_post(link);
          // const home_link = location.protocol + "//" + location.hostname + ":3000/home";
          const home_link = location.protocol + "//" + location.hostname + "/home";
          location.replace(home_link);
          return;
        } else {
          // const link = location.protocol + "//" + location.hostname + ":3000/create_judgement?oji=" + 0;
          const link = location.protocol + "//" + location.hostname + "/create_judgement?oji=" + 0;
          this.axios_post(link);
          // const home_link = location.protocol + "//" + location.hostname + ":3000/home";
          const home_link = location.protocol + "//" + location.hostname + "/home";
          console.log(home_link);
          location.replace(home_link);
          return;
        }
      }

      if (this.count == 1) {
        
        this.oji_answer = this.oji_answer + $oji_count;

        console.log("２回答");
        // const link = location.protocol + "//" + location.hostname + ":3000/get_judgement?id=" + this.question.id + "&id2=" + this.second_id + "&oji_answer=" + this.oji_answer;
        const link = location.protocol + "//" + location.hostname + "/get_judgement?id=" + this.question.id + "&id2=" + this.second_id + "&oji_answer=" + this.oji_answer;
        this.axios_get(link);
        this.count = 2;
        
      } else if (this.question) {//一度でもYESかNO押せばこっち
          console.log("１回答");
        this.oji_answer = this.oji_answer + $oji_count;
        // const link = location.protocol + "//" + location.hostname + ":3000/get_judgement?id=" + this.question.id + "&oji_answer=" + this.oji_answer;
        const link = location.protocol + "//" + location.hostname + "/get_judgement?id=" + this.question.id + "&oji_answer=" + this.oji_answer;
        this.axios_get(link);
        this.second_id = this.question.id;
        this.count = 1;
        
      } else {
        if(this.oji_answer >= 2){
          // const home_link = location.protocol + "//" + location.hostname + ":3000/home";
          const home_link = location.protocol + "//" + location.hostname + "/home";
          location.replace(home_link);
          return;
        }
          console.log("0回答");
        this.oji_answer = this.oji_answer + $oji_count;
        // const link = location.protocol + "//" + location.hostname + ":3000/get_judgement?oji_answer=" + this.oji_answer;
        const link = location.protocol + "//" + location.hostname + "/get_judgement?oji_answer=" + this.oji_answer;
        this.axios_get(link);
      }
          
      
    },
    yes() {
      this.getJudge(1);
      this.processing = true
    },
    no() {
        this.getJudge(0);
        this.processing = true
    },
    startProcessing() {
      this.processing = true;
    },
    endProcessing() {
      console.log("end!");
      this.processing = false;
    },
    isProcessing() {
      return this.processing;
    },
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
      <img :src="question.image" alt="" />
    </div>
    <div class="btn_group">
      <button
        class="btn btn-primary"
        @click="yes"
        v-bind:disabled="processing"
      >
        知ってる
      </button>
      <button
        class="btn btn-success ml-2"
        @click="no"
        v-bind:disabled="isProcessing()"
      >
        知らない
      </button>
    </div>
  </div>
</template>