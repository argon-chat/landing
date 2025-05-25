<template>
  <div
    class="relative flex size-full flex-col items-center justify-center overflow-hidden rounded-lg border bg-background  md:pb-60 md:shadow-xl"
  >
    <span
      class="pointer-events-none whitespace-pre-wrap bg-gradient-to-b from-black to-gray-300/80 bg-clip-text text-center text-8xl font-semibold leading-none text-transparent max-lg:-mt-12 dark:from-white dark:to-slate-900/10"
    >
      Argon Regionallity
    </span>
    <br/>
    <Globe class="top-128" />
    <div
      class="pointer-events-none absolute inset-0 h-full bg-[radial-gradient(circle_at_50%_200%,rgba(0,0,0,0.2),rgba(255,255,255,0))]"
    />
  </div>
</template>

<script lang="ts" setup>
import Globe from "./Globe.vue";
</script>