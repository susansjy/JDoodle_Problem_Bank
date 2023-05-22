<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { axios, lowdb } from '@/helper.js'

const route = useRoute()
const router = useRouter()

let questions = reactive([])

let isLoading = ref(true)
let questionsIndex = ref(route.query.questionsIndex ?? 0)
let question = computed(() => questions[questionsIndex.value])

function prevQuestion() {
  questionsIndex.value--
  initialQuestion()
}

function nextQuestion() {
  questionsIndex.value++
  initialQuestion()
}

function submitAllQuestions() {
  lowdb.data = questions
  lowdb.write()
  router.push('/result')
}

let socketClient = null
async function initialQuestion() {
  isLoading.value = true
  if (socketClient) {
    socketClient.disconnect()
  }

  const { token } = await axios.get('/websocketToken')
  socketClient = window.webstomp.over(new window.SockJS('https://api.jdoodle.com/v1/stomp'), {
    heartbeat: false,
    debug: false
  })
  socketClient.connect(
    {},
    () => {
      let wsNextId

      socketClient.subscribe('/user/queue/execute-i', (message) => {
        if (isLoading.value) {
          isLoading.value = false
        }

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
              questions[questionsIndex.value].answer += message.body + '\n'
            }
          }
        }

        wsNextId = msgSeq + 1
      })

      let data = JSON.stringify({
        script: '',
        language: 'nodejs',
        versionIndex: 4
      })

      socketClient.send('/app/execute-ws-api-token', data, { message_type: 'execute', token })
    },
    (e) => console.error(e)
  )
}
onMounted(async () => {
  const result = await axios.get('/fiveQuestions')
  questions = result.map((question) => ({ ...question, answer: '' }))
  initialQuestion()
})

function textareaOnKeypress(e) {
  socketClient.send('/app/execute-ws-api-token', e.key === 'Enter' ? '\n' : e.key, {
    message_type: 'input'
  })
}
</script>

<template>
  <div class="my-4">
    <div v-if="isLoading" class="d-flex justify-content-center">
      <div class="spinner-border">
        <span class="visually-hidden">Loading...</span>
      </div>
    </div>

    <div v-else>
      <div class="d-flex justify-content-between mb-4">
        <h3>FUNCTION NAME: {{ question.functionName }}</h3>

        <div class="btn-group" role="group" aria-label="Basic example">
          <button
            type="button"
            class="btn btn-primary"
            :disabled="questionsIndex < 1"
            @click="prevQuestion"
          >
            Prev
          </button>
          <button
            type="button"
            class="btn btn-primary"
            :disabled="questionsIndex >= questions.length - 1"
            @click="nextQuestion"
          >
            Next
          </button>
          <button type="button" class="btn btn-warning" @click="submitAllQuestions">
            Submit All
          </button>
        </div>
      </div>
      <div class="card">
        <div class="card-body">
          <p>{{ question.detail }}</p>

          <textarea
            rows="8"
            class="form-control"
            :placeholder="question.placeholder"
            v-model="questions[questionsIndex].answer"
            @keypress="textareaOnKeypress"
          />
        </div>
      </div>
    </div>
  </div>
</template>
