<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <header>
    <nav class="navbar">
      <div class="container">
        <a class="navbar-brand" href="#">
          <img src="@/assets/logo.svg" alt="Frontend" height="48" />
        </a>
      </div>
    </nav>
  </header>

  <main class="container">
    <RouterView />
  </main>
</template>

<style scoped></style>
