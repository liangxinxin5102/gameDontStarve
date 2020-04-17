<template>
  <div id="app">
    <h1>{{title}}</h1>
    <div class="registerwindow">
      <div class="title">用户注册</div>
      <div class="item">
        <div class="text">用户名:</div>
        <input type="text" v-model="username">
      </div>
      <div class="item">
        <div class="text">密码:</div>
        <input type="text" v-model="pwd">
      </div>
      <div class="item">
        <div class="text">邮箱:</div>
        <input type="text" v-model="email">
      </div>
      <div class="item">
        <div class="text">手机号:</div>
        <input type="text" v-model="phone">
        <button :disabled="disabled" @click="authPhone">{{codebtn}}</button>
      </div>
      <div class="item">
        <div class="text">验证码:</div>
        <input type="text" v-model="code">
        <button @click="authUserinfo">确认注册</button>
      </div>
    </div>
    <v-ctive :email='email'></v-ctive>
  </div>
</template>
<script>
    export default {
        name: 'app',
        data () {
            return {
                title: '首页',
                disabled:false,
                time:0,
                codebtn:'获取验证码',
                phone:'',
                username:'',
                pwd:'',
                code:'',
                email:''
        }
        },
        methods: {
            getCode(){
                //用来向后台发送请求获取验证码
            },
            goRegister(){
                //提交完整的注册信息
            },
            authPhone(){
                var reg=11 && /^((13|14|15|17|18)[0-9]{1}\d{8})$/;
                if(this.phone==''){
                    alert("请输入手机号码");
                }else if(!reg.test(this.phone)){
                    alert("手机格式不正确");
                }else{
                    this.time=60;
                    this.disabled=true;
                    this.timer();
                    this.getCode();
                }
            },
            timer() {
                if (this.time > 0) {
                    this.time--;
                    this.codebtn=this.time+"s";
                    setTimeout(this.timer, 1000);
                } else{
                    this.time=0;
                    this.codebtn="获取验证码";
                    this.disabled=false;
                }
            },
            authUserinfo(){
                if(this.username==''){
                    alert("用户名不能为空");
                }else if(this.pwd==''){
                    alert("密码不能为空");
                }else if(this.phone==''){
                    alert("手机号码不能为空");
                }else if(this.code==''){
                    alert("验证码不能为空");
                }else{
                    this.goRegister();
                }
            },
            getCode(){
                //用来向后台发送请求获取验证码
                var api='http://127.0.0.1:8000/sendcode/';
                Axios.get(api,{
                        params:{
                            phone:this.phone
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
            },
            goRegister(){
                //提交完整的注册信息
                var api='http://127.0.0.1:8000/register/';
                Axios.get(api,{
                        params:{
                            phone:this.phone,
                            username:this.username,
                            pwd:this.pwd,
                            code:this.code,
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
        }
    }
</script>
