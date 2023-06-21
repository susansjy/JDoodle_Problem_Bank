<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { axios, lowdb } from '@/helper.js'
import Cookies from 'js-cookie'

const route = useRoute()
const router = useRouter()


let username = ref(Cookies.get("jdoodle_username") ?? "")
let isCookieUsername = ref(!!username.value);


let socketClient = null
async function initialQuestion() {
  if (socketClient) {
    socketClient.disconnect()
  }

  const { token } = await axios.get('/websocketToken')
  socketClient = window.webstomp.over(new window.SockJS('https://api.jdoodle.com/v1/stomp'), {
    heartbeat: false,
    debug: true
  })
  socketClient.connect(
    {},
    () => {
      let wsNextId

      socketClient.subscribe('/user/queue/execute-i', (message) => {
        let msgId = message.headers['message-id']
        let msgSeq = parseInt(msgId.substring(msgId.lastIndexOf('-') + 1))
        let statusCode = parseInt(message.headers.statusCode)

        if (statusCode !== 201) {
          let t0
          try {
            t0 = performance.now()
            while (performance.now() - t0 < 2500 && wsNextId !== msgSeq);
          } catch (e) {
            console.error(e)
          }

          if (statusCode === 204) {
          } else if (statusCode === 500 || statusCode === 410) {
            console.error('server error')
          } else if (statusCode === 206) {
          } else if (statusCode === 429) {
            console.error('Daily limit reached')
          } else if (statusCode === 400) {
            console.log('Invalid token')
          } else if (statusCode === 401) {
            console.log('Unauthorised request')
          } else {
            if (message.body) {
              var txt = document.querySelector("textarea").value
              document.querySelector("textarea").value = txt + message.body + "\n"
            }
          }
        }

        wsNextId = msgSeq + 1
      })

      let data = JSON.stringify({
        script: `const readline = require('readline'); 
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
rl.question('What is your favorite food?', (answer) => {
  console.log("Oh, so your favorite food is " + answer);
});`,
        language: 'nodejs',
        versionIndex: 4
      })

      socketClient.send('/app/execute-ws-api-token', data, { message_type: 'execute', token })
    },
    (e) => console.error(e)
  )
}
onMounted(async () => {
  initialQuestion()
})

function saveMyUsername() {
  Cookies.set("jdoodle_username", username.value);
  isCookieUsername.value = true;
}

function textareaOnKeypress(e) {
  socketClient.send('/app/execute-ws-api-token', e.key === 'Enter' ? '\n' : e.key, {
    message_type: 'input'
  })
}
</script>

<template>
  <div>
    <div class="modal bg-white" :class="{ 'd-block': !isCookieUsername }">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Please enter your name</h5>
          </div>
          <div class="modal-body">
            <input type="text" class="form-control" placeholder="Enter your username" v-model="username">
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" @click="saveMyUsername">Save my username</button>
          </div>
        </div>
      </div>
    </div>
    <div class="my-4">
      <div class="d-flex justify-content-between mb-4">
        <h3>WebSocket example</h3>
      </div>
      <div class="card">
        <div class="card-body">
          <textarea
            rows="8"
            class="form-control"
            @keypress="textareaOnKeypress"
          />
        </div>
      </div>
    </div>
  </div>
</template>
