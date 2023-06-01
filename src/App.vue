<script setup lang="ts">
import Home from './components/Home/Home.vue'
import  testApi  from './sql/sql-api/test.js'
testApi.addTest({
    type:1,
    tel:'177****1111',
    cookie:'dsjadljsakldjsakldjkaslfklaj',
})
.then(res=>{
console.log(res);
})


</script>

<template>
  <div class="app">
    <Home />
  </div>
</template>

<style>
.app{
  /* width: 100%; */
  display: flex;
}
</style>
