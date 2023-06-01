<script setup lang="ts">
import { reactive } from 'vue'
const props = defineProps(['enterUser', 'subone', 'getTopic'])
const meTopic = ''
const yourTopic = ''
var state = reactive({ one: 0 })
const handleClick = (topic: any) => {
  state.one = topic
  props.getTopic(topic)
}
const userTable = [
  { name: '小红', txt: 'A一段文本', topic: 123 },
  { name: '小蓝', txt: 'B一段文本', topic: 456 },
  { name: '小绿', txt: 'C一段文本', topic: 789 },
]
</script>
<template>
  <!-- <div class="sider-div"> -->
  <!-- 对方Topic:<input type="text" v-model="yourTopic" >
    <button @click="props.enterUser(yourTopic)" >锁定</button><br/>
    本人Topic:<input type="text" v-model="meTopic" >
    <button @click="props.subone(meTopic)" >锁定</button> -->
  <!-- </div> -->
  <template v-for="(item, index) in userTable" :key='item.topic'>
    <div class="sider-div" @click="handleClick(item.topic)" :class="{ active: state.one == item.topic }">
      <div class="div-left">
        <img src="../../../../assets/images/人.png" alt="">
      </div>
      <div class="div-right">
        <p>{{ item.name }}</p>
        <p>{{ item.txt }}</p>
      </div>
    </div>
  </template>
</template>

<style scoped lang="scss" >
.active {
  background-color: rgba(136, 136, 136, 0.288) !important;
}

.sider-div {
  width: 100%;
  height: 65px;
  // background-color: rgb(110, 187, 47);
  display: flex;

  &:hover {
    background-color: rgba(134, 134, 134, 0.068);

  }
}

.div-left {
  width: 40px;
  height: 40px;
  overflow: hidden;
  margin: 12px;
}

.div-right {
  margin: 10px 15px 13px 0px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  p:nth-child(1) {
    // background-color: aqua;
    font-size: 14px;
  }

  p:nth-child(2) {
    // background-color: aqua;
    color: #999;
    font-size: 12px;
  }
}</style>