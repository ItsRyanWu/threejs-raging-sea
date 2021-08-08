<template>
  <Sea/>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import Sea from './components/Sea.vue'

export default defineComponent({
  name: 'App',
  components: {
    Sea
  }
})
</script>

<style>
body {
  margin: 0;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
