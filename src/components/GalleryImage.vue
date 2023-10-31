<script setup lang="ts">
export interface Props {
  href:string;
  src: string;
  caption: string;
  desc: string;
}

defineProps<Props>();
</script>

<template>
  <div class="img-box">
    <a :href="href">
      <img :src="src" alt="" />
      <div class="transparent-box">
        <div class="caption">
          <p>{{ caption }}</p>
          <p class="opacity-low">{{ desc }}</p>
        </div>
      </div>
    </a>
  </div>
</template>

<style scoped>
.img-box {
  box-sizing: content-box;
  margin: 10px;
  height: auto;
  width: 350px;
  overflow: hidden;
  display: inline-block;
  color: rgb(228, 215, 215);
  position: relative;
  background-color: transparent;
}

.caption {
  position: absolute;
  bottom: 5px;
  left: 20px;
  opacity: 0;
  transition: transform 0.3s ease, opacity 0.3s ease;
}

.transparent-box {
  height: auto;
  width: 350px;
  background-color: rgba(0, 0, 0, 0);
  position: absolute;
  top: 0;
  left: 0;
  transition: background-color 0.3s ease;
}

.img-box:hover img {
  transform: scale(1.1);
}

.img-box:hover .transparent-box {
  background-color: rgba(99, 179, 236, 0.5);
}

.img-box:hover .caption {
  transform: translateY(-20px);
  opacity: 1;
}

.img-box:hover {
  cursor: pointer;
}

.caption > p:nth-child(2) {
  font-size: 0.8em;
}

.opacity-low {
  opacity: 0.5;
}
</style>