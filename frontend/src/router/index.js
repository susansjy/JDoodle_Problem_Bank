import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/result',
      name: 'result',
      component: () => import('../views/ResultView.vue')
    },
    {
      path: '/answer',
      name: 'answer',
      component: () => import('../views/AnswerView.vue')
    },
    {
      path: '/socket',
      name: 'socket',
      component: () => import('../views/SocketView.vue')
    }
  ]
})

export default router
