<script setup lang="ts">
import { onMounted, reactive, watch, ref, nextTick } from 'vue'
import {SQLiteInit,insertMessage,selectMessage} from '../../sql/index.js'
const db = SQLiteInit()
const mqtt = require('mqtt')
import List from './components/List/List.vue'
import SideBar from './components/SideBar/SideBar.vue'
let SendValue = ""
var vyouTopic:any
var vmeTopic:any
const getdiv = ref(null)
// const changeChildMessage = ref(null)
const client = mqtt.connect('mqtt://106.75.71.119:1883')

const state = reactive({message: []})
// 提供一个 getter 函数
watch(
  () => state.message,
  (message) => {
    // console.log(JSON.stringify(message))
    console.log(message,'新的')
    // SELSQL(db,vyouTopic,JSON.stringify(message))
  }
)
const topic = '1'
onMounted(()=>{
  // console.log(vmeTopic)
  client.on('connect', () => {
    console.log('Connected')
    client.subscribe([topic], () => {
      console.log(`Subscribe to topic '${topic}' `)
    })
    
  })
  client.on('message', (topic, payload) => {
    // console.log('first',topic,payload.toString())
    insertMessage(db,vyouTopic,vmeTopic,payload.toString(),(data) => {
        state.message = [...state.message, data[0]]
        nextTick(() => {
          getdiv.value.scrollTop = getdiv.value.scrollHeight
        })
      })
    // state.message = [...state.message, { who: 'rebot', text: payload.toString() }]
    // console.log(topic,'555')
    /* if(changeChildMessage.value.userTable === undefined){
        return
      } */
    /* else{console.log(changeChildMessage.value.userTable.filter((item) => {
      if(item.topic == undefined) return
        if(item.topic.toString() === vyouTopic){
          item.message = state.message
          return item
        }
      }),'vyouTopic:',vyouTopic)} */
  })
})
  
  

// onMounted(()=>{
//   // setTimeout(()=>{
//   //   subone(me)
//   // },1000)
  

//   // console.log(me)
//   // console.log('start')
// })


// /* 连接MQTT服务器 */
// let connect = () => {
//   // 连接
//   client.on('connect',
//     function (connack) {
//       console.log('MQTT连接成功')
//     })
//   // subone(me)
//     client.subscribe(me, () => {
//       console.log(me)
//     })

//   client.on("message", function (topic, payload) {
//     console.log(topic, payload.toString())
//     // console.log(first)
//     state.message = [...state.message, { who: 'rebot', text: payload.toString() }]
//   })
//   client.on("error", function (error) { console.log("MQTT Server Error 的回调" + error) })
// 			//服务器重连连接异常的回调
// 	client.on("reconnect", function () { console.log("MQTT Server Reconnect的回调") })
// 			//服务器连接异常的回调
// 	client.on("offline", function (errr) { console.log("MQTT Server Offline的回调" + errr) })

// }

// let subone = (Topic) => {
//     console.log(Topic)
// 		var ok = false;
// 		if (client && client.connected) {
// 			client.subscribe(Topic, function (err, granted) {
// 				if (!err) { 
// 					console.log('订阅主题 ' + Topic + ' 成功') 
// 					ok = true;
// 				}else { console.log('订阅主题 ' + Topic + ' 失败') 
// 					ok = false;
// 				}
// 			})
// 		} else {
// 			console.log('请先连接服务器')
// 			ok = false;
// 		}
// 		return ok;
// 	};
  let PubMsg = (Topic, Msg) => {
		if (client && client.connected) {
			client.publish(`${Topic}`, Msg);
			console.log('发布成功->' + Topic + '->' + Msg)
      insertMessage(db,vmeTopic,vyouTopic,Msg,(data) => {
        state.message = [...state.message, data[0]]
        // console.log(getdiv.value.scrollTop)
        nextTick(() => {
          getdiv.value.scrollTop = getdiv.value.scrollHeight
        })
      })
      // state.message = [...state.message, {id:5, formid:1, toid:3 ,context: Msg }]
      /* if(changeChildMessage.value.userTable === undefined){
        return
      }else{
        console.log(changeChildMessage.value.userTable.filter((item) => {
        if(item.topic.toString() === Topic){
          item.message = state.message
          return item
        }
      }))
      } */
      

		} else {
			console.log('请先连接服务器')
		}
	};


// const enterUser = (youTopic: any)=> {
//   vyouTopic = youTopic
// }
//触发
const handleSend = () => {
  PubMsg(vyouTopic,SendValue)
  SendValue = ''
}
const getscroll = (e) => {
  if(e.target.scrollTop == 0){
    let i = state.message.length
    selectMessage(db,vmeTopic,vyouTopic,(data) => {
    state.message = [...data,...state.message]
    nextTick(() => {
      if(i = 0){
        e.target.scrollTop = 0
      }else
        e.target.scrollTop = i*80-80
        console.log(e.target.scrollTop)
        })
  },i)
  
  }

}
  // subone(vyourTopic);
  /* state.message = [...state.message, { who: 'person', text: SendValue }]
  SendValue = ""
  setTimeout(() => {
    state.message = [...state.message, { who: 'rebot', text: "我不知道你在说什么" }]
  }, 800) */
// }

/*****传送给子组件的函数***获取侧边栏的topic值*****/
const getMessage = (message: any,other_id: any,me_id: any) => {
  vyouTopic = other_id
  vmeTopic = me_id
  console.log(vyouTopic, '哈哈')
  state.message = message
  console.log(state.message)
}
</script>

<template>
  <div class="box">
    <SideBar :getMessage="getMessage" />
  </div>
  <div class="main">
    <div @scroll="getscroll($event)" ref="getdiv" class="main-top">
      <template v-for="(item, index) in state.message">
        <List :who="item.fromid" :text="item.context" />
      </template>
    </div>
    <div class="home-input">
        <textarea  v-model="SendValue"></textarea>
        <div>
          <button @click="handleSend()" >发送</button>
        </div>
      </div>
  </div>
</template>

<style scoped lang="scss">
.hh {
  height: 70px;
  width: 100%;
  background-color: orange;
}

.box {
  box-sizing: border-box;
  height: 100vh;
  flex-basis: 250px;
  background-color: rgba(204, 204, 204, 0.486);
  overflow-y: scroll;
  border-right: 1px solid #99999936;
    &::-webkit-scrollbar {
      width: 5px;
      height: 5px;
    }
    &::-webkit-scrollbar-thumb {
      border-radius: 10px;
      background: #7070706c;
    }
    &::-webkit-scrollbar-track {
      border-radius: 10px;
    };
  
}

.main {
  height: 100vh;
  flex: 1;
  display: flex;
  flex-direction: column;

  .main-top {
    flex: 1;
    overflow-y: scroll;

    &::-webkit-scrollbar {
      width: 5px;
      height: 5px;
    }
    &::-webkit-scrollbar-thumb {
      border-radius: 10px;
      background: #7070706c;
    }
    &::-webkit-scrollbar-track {
      border-radius: 10px;
    }
  }
}

.home-input {
  box-sizing: border-box;
  width: 100%;
  height: 120px;
  background-color: #e9e9e9;
  line-height: 0;
  padding: 10px 0;
  // display: flex;
  // justify-content: center;
  // align-items: center;

  textarea,
  button {
    font-family: '楷体';
    box-sizing: border-box;
    font-size: 15px;
    box-sizing: border-box;
    // background-color: #fff;
    border: 1px solid #c9c9c9;
  }

  textarea {
    background-color: #e9e9e9;
    line-height: 1;
    resize: none;
    padding: 10px;
    width: 100%;
    height: 55px;
    border-radius: 5px 0 0 5px;
    border: none;
    outline: none;
    position: relative;
    &::-webkit-scrollbar {
      width: 5px;
      height: 5px;
    }
    &::-webkit-scrollbar-thumb {
      border-radius: 10px;
      background: #7070706c;
    }
    &::-webkit-scrollbar-track {
      border-radius: 10px;
    }
  }

  button {
    position: absolute;
    right: 20px;
    bottom:5px;
    box-sizing: border-box;
    height: 30px;
    width: 70px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    color: green;
    background-color: #ffffff3a;
  }
  div{
    position: relative;
    height: 45px;
    width: 100%;
  }
}</style>
