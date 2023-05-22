<script setup>
import { reactive, onMounted } from 'vue'
import { map } from 'lodash'
import { axios, lowdb } from '@/helper.js'

lowdb.read()
let questions = reactive(lowdb.data)

onMounted(() => {
  questions.forEach(({ answer, testCases }, index) => {
    axios
      .post('/nodeJSExecute', {
        script: [answer, ...map(testCases, 'code')].join(';')
      })
      .then(({ result }) => {
        const resultArray = result.split(/\s/)

        for (let i = 0; i < questions[index].testCases.length; i++) {
          questions[index].testCases[i].passed = resultArray[i] === 'true'
        }
      })
  })
})
</script>

<template>
  <div class="accordion">
    <div
      class="accordion-item"
      v-for="{ id, functionName, detail, answer, testCases } in questions"
      :key="id"
    >
      <h2 class="accordion-header">
        <button
          class="accordion-button"
          type="button"
          data-bs-toggle="collapse"
          :data-bs-target="'#accordion' + id"
        >
          {{ functionName }}
        </button>
      </h2>
      <div :id="'accordion' + id" class="accordion-collapse collapse show">
        <div class="accordion-body">
          <p>{{ detail }}</p>

          <h6 class="mt-4">Your answer</h6>
          <code>{{ answer }}</code>

          <h6 class="mt-4">Test cases</h6>
          <div
            class="d-flex justify-content-between align-items-center my-2"
            v-for="{ caseId, code, passed } in testCases"
            :key="caseId"
          >
            <code>{{ code }}</code>

            <div v-if="passed === undefined" class="spinner-border">
              <span class="visually-hidden">Loading...</span>
            </div>

            <p v-else-if="passed === true" class="text-success mb-0"><strong>PASSED</strong></p>

            <p v-else class="text-danger mb-0"><strong>ERROR</strong></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
