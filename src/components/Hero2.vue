<template>
    <div class="flex flex-col overflow-hidden">
        <ContainerScroll>
            <template #title>
                <h1 class="text-4xl font-semibold text-white">
                    Unleash the power of <br />
                    <span class="mt-1 text-4xl font-bold leading-none md:text-[6rem]">
                        Social Activity
                    </span>
                </h1>
            </template>
            <template #card>
                <img :src="bg.src" class="mx-auto h-full rounded-2xl object-cover object-left-top" alt="hero"
                    :height="bg.height" :width="bg.width" />
            </template>
        </ContainerScroll>
    </div>
</template>
<script setup lang="ts">
import ContainerScroll from "./ContainerScroll.vue";
import bg from "../assets/argon-img.png"
</script>