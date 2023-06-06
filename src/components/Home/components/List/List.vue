<script setup lang="ts">
import { string } from 'yargs';
import ren from '../../../../assets/images/人.png'
import ji from '../../../../assets/images/机.png'
import 'animate.css'
const props = defineProps(['who','text'])
</script>

<template>
  <div class="message-div">
    <div class="message-info">
      <div class="one">
        <img v-if="props.who === 1" :src=ren alt="">
        <img v-if="props.who !== 1" :src=ji alt="">
      </div>
      <div class="two">
        <p>{{ props.text }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss" >
.message-div{
  box-sizing: border-box;
  height: 80px;
  width: 100%;
  // background-color: red;
  .message-info{
    margin: 0 auto;
    width: 80%;
    height: 100%;
    // padding: 0 2%;
    display: flex;
    align-items: center;
    border-bottom: 1px solid #00000027;
    .one,.two{
      height: 60%;
    }
    .one{
      width: 80px;
      // background-color: red;
      text-align: center;
      display: flex;
      align-items:center;
      justify-content: center;
      img{
        width: 30px;
        height: 30px;
      }
    }
    .two{
      width: 100%;
      // line-height: 100%;
      // background-color: blue;
      display: flex;
      align-items:center;

    }
  }
}
</style>