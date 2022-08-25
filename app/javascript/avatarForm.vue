<template>
  <div>
    <h2 class="text-center mt-5">画像登録</h2>
    <div class="p-form__group">
      <image-upload @hide_btn="hide_btn" @show_btn="show_flg" @imagePath="image = $event" />
      <div class="error">
        <p>{{ error }}</p>
      </div>
      <span  v-if="show_btn" @click="updateAvatar" class="btn btn-primary">これで登録</span>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import imageUpload from "./imageUpload.vue";

export default {
  components: { imageUpload },
  data() {
    return {
      image: null,
      error: null,
      show_btn:false,
      userId:""
    };
  },
  methods: {
    show_flg(){
      console.log('show!');
      this.show_btn = true;
    },
    hide_btn(){
      console.log('hide');
      this.show_btn = false;
    },
    
    updateAvatar() {
      console.log('update');
      
      //バックエンドに送るフォームを生成

      let formData = new FormData();
      formData.append(
        "user[avatar]", 
        this.image["blob"],
         this.image["fileName"]);
      try {
        const res = axios.post(
          location.protocol + "//" + location.hostname + `/auth/${this.userId}/avatar`,
          // `http://localhost:3000/auth/${this.userId}/avatar`,
          formData,
          {
            headers: {
              "Content-Type": "application/json",
            },
          }
        );
        if (!res) {
          this.error = "新規登録できませんでした";
          throw new Error("ログインできませんでした");
        }
        if (!this.error) {
          console.log("登録成功");
          console.log(res);


          // window.sessionStorage.setItem([プロパティ名],[値])でセッションに保存できる。
          window.sessionStorage.setItem(
            ["flash_message"],
            ["アイコンを登録しました"]
          );
        }
        // return res;
      } catch (error) {
        console.log(error);
        this.error = "登録に失敗しました";
      }

      //  const link = location.protocol + "//" + location.hostname + ":3000" + "/old_judgements";
       const link = location.protocol + "//" + location.hostname + "/old_judgements";

       setTimeout(function(){
        location.replace(link);
      },400)

      
    },
    getUser(){
      // axios.get("http://localhost:3000/get_user").then((res) => {
      //     this.userId = res.data.id
      //     console.log('idだよ');
      //     console.log(this.userId);
      //     console.log(res.data);
          
      //     return res;
      //   })
      //   .catch(function (err) {
      //     console.log(err);
      //   });

      axios.get(location.protocol + "//" + location.hostname + "/get_user").then((res) => {
          this.userId = res.data.id
          console.log(this.userId);
          return res;
        })
        .catch(function (err) {
          console.log(err);
        });

    }//.getUserEnd
  },
  mounted() {
    console.log(this.userId);
    
  },
  created(){
    
    this.getUser();
  }
};
</script>

