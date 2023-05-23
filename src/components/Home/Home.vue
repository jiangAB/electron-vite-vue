<script setup lang="ts">
import { reactive } from 'vue'
import List from './components/List/List.vue'

const state = reactive({
  message:[
  {who:'rebot',text:'你好,有什么为您效劳的'},
  ]
})
// const a = reactive({count:1})
// console.log(message)
let SendValue = ""
const handleSend = () =>{
  // console.log('first')
  // console.log(SendValue)
  state.message =[...state.message,{who:'person',text:SendValue}]
  SendValue = ""
  setTimeout(()=>{
    state.message =[...state.message,{who:'rebot',text:"我不知道你在说什么"}]
  },800)

  // console.log(message)
}
</script>

<template>
  <template v-for="(item,index) in state.message">
    <List :who="item.who" :text="item.text" />
  </template>
  
  <div class="home-input">
    <input  type="text" v-model="SendValue"  placeholder="请输入内容"> 
    <button @click="handleSend" >Send</button>
  </div>
</template>

<style scoped lang="scss">
.home-input{
  width: 100%;
  height: 70px;
  background-color: #fff;
  position: fixed;
  bottom: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;

  input,button{
    font-size: 18px;
    box-sizing: border-box;
    background-color: #fff;
    border: 1px solid #c9c9c9;
  }
  input{
    padding: 10px;
    width: 70%;
    height: 55%;
    border-radius: 5px 0 0 5px;
    border-right: 0px;
    outline:none;
  }
  button{
    height: 55%;
    border-radius: 0 5px 5px 0;
    border-left: 0px;
    padding: 0 20px;
    cursor: pointer;
  }
  
}
</style>
