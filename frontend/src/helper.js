import axiosCreate from 'axios'
import { LocalStorage } from 'lowdb/browser'
import { LowSync } from 'lowdb'
export const lowdb = new LowSync(new LocalStorage('questions'), [])

export const axios = axiosCreate.create({
  baseURL: 'http://localhost:3000/',
  timeout: 5000
})

axios.interceptors.response.use(
  (response) => response.data,
  (e) => {
    return Promise.reject(e)
  }
)
