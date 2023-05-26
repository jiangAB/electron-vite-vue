<script setup lang="ts">

const props = defineProps(['enterUser','subone'])
const meTopic = ''
const yourTopic = ''
</script>
<template>
  <div class="sider-div">
    对方Topic:<input type="text" v-model="yourTopic" >
    <button @click="props.enterUser(yourTopic)" >锁定</button><br/>
    本人Topic:<input type="text" v-model="meTopic" >
    <button @click="props.subone(meTopic)" >锁定</button>
  </div>
</template>

<style scoped lang="scss" >
.sider-div{
input{
  width: 100px;
}
}
</style>