<script setup lang="ts">
import { reactive } from 'vue'
import { SQLiteInit,selectMessage,selectList } from '../../../../sql/index.js'

const db = SQLiteInit()

const props = defineProps(['enterUser', 'subone', 'getMessage'])
const meTopic = ''
const yourTopic = ''
var state = reactive({ one: 0,message:[],chatList:[] })

selectList(db, (data) => {
  console.log(data)
  state.chatList = data
    // data.map((item) => {
    //   return item.message = JSON.parse(item.message)
    // })
    // console.log(data, '123123123')
    // userTable =
    // state.userTable = data
    // console.log(state.userTable,'dasfds')
  })
// let userTable = [
//   {
//     name: '小红', txt: 'A一段文本', topic: 123,
//     message: [
//       { who: 'rebot', text: '小红你好,有什么为您效劳的' },
//       { who: 'person', text: '6666' },
//     ]
//   },
//   {
//     name: '小蓝', txt: 'B一段文本', topic: 456, message: [
//       { who: 'rebot', text: '小蓝你好,有什么为您效劳的' },
//     ]
//   },
// ]

const handleClick = (me_id,other_id) => {

  state.one = other_id
  console.log(me_id,other_id,'123')
  selectMessage(db,me_id,other_id,(data) => {
    // state.message = data
    props.getMessage(data,other_id,me_id)
  })
  // console.log(a)
  // console.log(selectMessage(db,me_id,other_id))
  // console.log(topic)
  // console.log(topic)
  // selectMessage(db,topic,(data) => {
  //   console.log(data,'666666')
  // })
  /* INSQL(db, (data) => {
    data.map((item) => {
      return item.message = JSON.parse(item.message)
    })
    console.log(data, '123123123')
    // userTable =
    state.userTable = data
  }) */

  // INSQL(db,(data)=>{
  //   console.log(userTable)
  // // userTable = data
  // // const arr = JSON.parse(data[0].message)
  // // console.log(arr)
  // // console.log(data[0].message,typeof(data[0].message))
  // // console.log(data)
  // data.map((item) => {
  //   return item.message = JSON.parse(item.message)
  // })
  // // console.log(data,'666')
  // // console.log(userTable, '123123')
  // userTable = data
  // console.log(userTable)
  // });

  // console.log(easd)
  /* const newtxt = state.userTable.filter(item =>
    item.topic === topic
  ) */
  // console.log(newtxt[0].message)
  /* props.getTopic(topic, newtxt[0].message)
 */
  // console.log(newtxt,'newtxt')
}


defineExpose({
  state
})
// runSQL(db,userTable)
//  console.log(ee)

</script>
<template>
  <!-- <div class="sider-div"> -->
  <!-- 对方Topic:<input type="text" v-model="yourTopic" >
    <button @click="props.enterUser(yourTopic)" >锁定</button><br/>
    本人Topic:<input type="text" v-model="meTopic" >
    <button @click="props.subone(meTopic)" >锁定</button> -->
  <!-- </div> -->
  <template v-for="(item, index) in state.chatList" :key='item.other_id'>
    <div class="sider-div" @click="handleClick(item.me_id,item.other_id)" :class="{ active: state.one == item.other_id }">
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
}
</style>