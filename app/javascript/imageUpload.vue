<script>
import Croppie from "croppie";
export default {
  emits: ["imagePath"],
  data() {
    return {
      image: null,
      croppie: null,
      url: "",
      imageName: "",
      previewFile: false,
      croppieFile: null,
      blob:'',
      shouldCropp:true
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
      this.setUpCroppie();
    },
    setUpCroppie() {
      if (this.previewFile) {
        console.log("イメージ");
        console.log(this.image);
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
      console.log("emitファイル");
      console.log(this.imageName);
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
          let bin = atob(response.replace(/^.*,/, ""));
          let buffer = new Uint8Array(bin.length);
          for (let i = 0; i < bin.length; i++) {
            buffer[i] = bin.charCodeAt(i);
          }
          this.blob = new Blob([buffer.buffer], {
            type: "image/gif",
          });
          console.log(this.blob);
          console.log(this.imageName.name);
          this.croppieFile = response;
          this.$emit("imagePath",{
            blob:this.blob,
            fileName:this.imageName.name
          });
        });
    },
  },
  mounted() {},
};
</script>

<template>
  <div class="Image-uploader-wrapper Image-uploader">
      <input
        accept="image/png, image/jpeg, image/bmp"
        name="image"
        type="file"
        @change="onImageUploaded"
        ref="image"
      />
    <div id="croppie" v-show="shouldCropp">
      <span
        @click="cropFile"
        class="p-croppie__btn btn-success"
        v-if="previewFile"
      >
        切り抜き
      </span>
    </div>
    <img id="js-drawPicture" :src="croppieFile" alt="" v-if="!shouldCropp" />
  </div>
</template>
