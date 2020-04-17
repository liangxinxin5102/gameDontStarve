<template>
  <div>
    <h1>{{title}}</h1>
    <button @click="sendcode">认证激活</button>
  </div>
</template>
<script>
    import Axios from 'axios';
    export default {
        data () {
            return {
                title: '认证激活组件',
            }
        },
        props:['email'],
        methods: {
            sendcode(){
                //   alert(this.email)
                var api='http://127.0.0.1:8000/sendactivecode/';
                Axios.get(api,{
                        params:{
                            email:this.email
                        }
                    }
                )
                    .then((Response)=>{
                        console.log(Response.data)
                        // 根据返回的信息，做出响应的提示
                    })
                    .catch((error)=>{
                        console.log(error)
                    })
            }
        },
    }
</script>
<style>
</style>
