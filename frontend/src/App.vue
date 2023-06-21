<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <header>
    <nav class="navbar">
      <div class="container">
        <img src="@/assets/logo.png" alt="Frontend" height="32" />
        

        <router-link to="/answer">
          <button type="button" class="btn btn-primary">My All Answers</button>
        </router-link>
      </div>
    </nav>
  </header>

  <main class="container">
    <RouterView />
  </main>
</template>

<style scoped></style>
