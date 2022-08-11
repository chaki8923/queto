<script>
import Croppie from "croppie";
import axios from 'axios';
//CSRFトークン生成
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;
export default {
  data() {
    return {
      image: null,
      croppie: null,
      url: "",
      imageName: "",
      previewFile: false,
      croppieFile: null,
      blob:'',
      shouldCropp:true,
      imagePath:'',
      error:''
    };
  },
  methods: {
    onImageUploaded(e) {
      this.shouldCropp = true
      const file = e.target.files[0];
      //cropp表示用
      this.image = URL.createObjectURL(file);
      //railsに渡す用。切り抜きしなければそのまま登録
      this.imageName = file;
      // 親コンポーネントの登録ボタン非表示
      this.$emit('hide_btn');
      this.setUpCroppie();
    },
    setUpCroppie() {
      //既に切り抜き画像があれば削除
      if (this.previewFile) {
        this.croppie.destroy();
      }
      let el = document.getElementById("croppie");
      this.croppie = new Croppie(el, {
        viewport: {
          width: 200,
          height: 200,
          type: "circle",
        },
        boundary: {
          width: 260,
          height: 260,
        },
        showZoomer: true,
        enableOrientation: true,
      });
      this.croppie.bind({
        url: this.image,
      });
      this.previewFile = true;

      this.$emit("imagePath", this.imageName);
    },
    cropFile() {
      this.shouldCropp = false;
      this.croppie
        .result({
          type: "canvas",
          size: "viewport",
        })
        .then((response) => {
          //======Base64からblobへ変換============
          let bin = atob(response.replace(/^.*,/, ""));
          let buffer = new Uint8Array(bin.length);
          for (let i = 0; i < bin.length; i++) {
            buffer[i] = bin.charCodeAt(i);
          }
          this.blob = new Blob([buffer.buffer], {
            type: "image/gif",
          });
        //=======================================
          this.croppieFile = response;
          this.imagePath = this.blob,
          this.$emit("imagePath",{
            blob:this.blob,
            fileName:this.imageName.name,
          });
          this.$emit('show_btn');
        });
    },
  },
  mounted() {},
};
</script>
<template>
  <div class="Image-uploader-wrapper Image-uploader">
    <div class="file-btn__group">
      <input
        accept="image/png, image/jpeg, image/bmp"
        type="file"
        @change="onImageUploaded"
        ref="image"
        class="file-btn"
      />
      <span class="btn btn-secondary">ファイルを選択</span>
    </div>
    <div id="croppie" v-show="shouldCropp">
      <span
        @click="cropFile"
        class="p-croppie__btn btn-success"
        v-if="previewFile"
      >
        切り抜く
      </span>
    </div>
    <img id="js-drawPicture" class="confirm-image" :src="croppieFile" alt="" v-if="!shouldCropp" />
    {{error}}

  </div>
</template>