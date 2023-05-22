<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <header>
    <nav class="navbar">
      <div class="container">
        <a class="navbar-brand" href="#">
          <img src="@/assets/jdoodle.png" alt="Frontend" height="36" />
        </a>
      </div>
    </nav>
  </header>

  <main class="container">
    <RouterView />
  </main>
</template>

<style scoped></style>
