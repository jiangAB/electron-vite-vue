<script setup lang="ts">
import { reactive } from 'vue'
const mqtt = require('mqtt')
import List from './components/List/List.vue'
import SideBar from './components/SideBar/SideBar.vue'

var vyouTopic:any = ''

const state = reactive({
  message: [
    { who: 'rebot', text: '你好,有什么为您效劳的' },
  ]
})

let SendValue = ""


  const client = mqtt.connect('mqtt://106.75.71.119:1883')
  // 连接
  client.on('connect',
    function (connack) {
      console.log('MQTT连接成功')
    })
  client.on("message", function (topic, payload) {
    console.log(topic, payload.toString())
    state.message = [...state.message, { who: 'rebot', text: payload.toString() }]
  })
  client.on("error", function (error) { console.log("MQTT Server Error 的回调" + error) })
			//服务器重连连接异常的回调
	client.on("reconnect", function () { console.log("MQTT Server Reconnect的回调") })
			//服务器连接异常的回调
	client.on("offline", function (errr) { console.log("MQTT Server Offline的回调" + errr) })

let subone = function(Topic) {
		var ok = false;
		if (client && client.connected) {
			client.subscribe(Topic, function (err, granted) {
				if (!err) { 
					console.log('订阅主题 ' + Topic + ' 成功') 
					ok = true;
				}else { console.log('订阅主题 ' + Topic + ' 失败') 
					ok = false;
				}
			})
		} else {
			console.log('请先连接服务器')
			ok = false;
		}
		return ok;
	};

  let PubMsg = function(Topic, Msg) {
		if (client && client.connected) {
			client.publish(Topic, Msg);
			// console.log('发布成功->' + Topic + '->' + Msg)
      state.message = [...state.message, { who: 'person', text: Msg }]
		} else {
			console.log('请先连接服务器')
		}
	};


const enterUser = (youTopic: any)=> {
  vyouTopic = youTopic
}

const handleSend = () => {
  PubMsg(vyouTopic,SendValue)
  // subone(vyourTopic);
  /* state.message = [...state.message, { who: 'person', text: SendValue }]
  SendValue = ""
  setTimeout(() => {
    state.message = [...state.message, { who: 'rebot', text: "我不知道你在说什么" }]
  }, 800) */
}
</script>

<template>
  <div class="box">
    <SideBar :enterUser="enterUser" :subone="subone" />
  </div>
  <div class="main">
    <div class="main-top">
      <template v-for="(item, index) in state.message">
        <List :who="item.who" :text="item.text" />
      </template>
    </div>
    <div class="home-input">
        <textarea  v-model="SendValue"></textarea>
        <div>
          <button @click="handleSend">发送</button>
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
  height: 100vh;
  flex-basis: 250px;
  background-color: red;
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
