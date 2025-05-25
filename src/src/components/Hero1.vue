<template>
    <section class="relative flex min-h-screen w-full flex-col items-center justify-center">
        <FallingStarsBg class="bg-black" />
        <Header />
        <div class="absolute inset-0 z-[1] bg-black opacity-50"></div>
        <div class="z-[2] flex max-w-xl flex-col items-center gap-2">
            <BlurReveal :delay="0.5" class="flex flex-col items-center justify-center gap-4">

                <span style="font-size: 2rem;"
                    class="flex flex-col items-center justify-center bg-gradient-to-b from-neutral-200 to-neutral-500 bg-clip-text text-center text-4xl font-bold text-transparent md:text-6xl">
                    Created to communicate, play, have fun, share and organize
                </span>
                <div class="flex min-h-64 items-center justify-center">
                    <RainbowButton @click="openModal">
                        Enroll to beta
                    </RainbowButton>
                </div>
                <br />

                <div
                    class="relative flex h-fit w-full flex-col items-center justify-center overflow-hidden rounded-lg border bg-background p-px md:shadow-xl">
                    <img :src="bg.src" class="w-full rounded-md" />
                    <BorderBeam :size="250" :duration="12" :delay="9" :border-width="2" />
                </div>
            </BlurReveal>
        </div>
    </section>
    <Transition enter-active-class="transition-opacity duration-300" enter-from-class="opacity-0"
        enter-to-class="opacity-100" leave-active-class="transition-opacity duration-300" leave-from-class="opacity-100"
        leave-to-class="opacity-0">

        <div v-if="showModal"
            class="fixed inset-0 z-[100] flex size-full items-center justify-center backdrop-blur-2xl">
            <div
                class="relative flex h-[250px] w-[500px] flex-col items-center justify-center overflow-hidden rounded-lg border bg-background md:shadow-xl">
                <div class="w-full w-full h-full rounded-lg bg-black p-6 shadow-xl">
                    <h2 class="mb-4 text-xl font-semibold text-white" style="text-align: center;">Enroll in Beta</h2>
                    <IInput v-model="email" type="email" placeholder="Enter your email" />
                    <div v-if="error" class="mb-2 text-red-600 text-sm">{{ error }}</div>
                    <br/>
                    <div class="flex justify-center gap-2">
                        <RainbowButton @click="submitEmail" :disabled="loading">
                            {{ loading ? 'Submitting...' : 'Submit' }}
                        </RainbowButton>
                    </div>
                </div>
                <BorderBeam :size="250" :duration="10" :delay="1" :border-width="2" />
            </div>

            <div class="absolute inset-x-0 bottom-0 z-20 h-full bg-white bg-gradient-to-t [mask-image:radial-gradient(900px_at_center,transparent_30%,white)] dark:bg-black"
                style="z-index: -5;">
            </div>
        </div>

    </Transition>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import BlurReveal from "./BlurReveal.vue";
import BorderBeam from "./BorderBeam.vue";
import FallingStarsBg from "./FallingStarsBg.vue";
import FlipWords from "./FlipWords.vue";
import bg from "../assets/argon-img.png"
import Header from "./Header.vue";
import RainbowButton from "./RainbowButton.vue";
import IInput from "./IInput.vue";

const showModal = ref(false)
const email = ref('')
const loading = ref(false)
const success = ref(false)
const error = ref('')
const openModal = () => {
    showModal.value = true
    email.value = ''
    error.value = ''
    success.value = false
}

const submitEmail = async () => {
    if (!email.value || !email.value.includes('@')) {
        error.value = 'Please enter a valid email.'
        return
    }

    loading.value = true
    error.value = ''
    try {
        const res = await fetch('https://api.argon.gl/api/enroll-beta', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: email.value })
        })

        if (!res.ok) throw new Error('Submission failed')

        success.value = true
        showModal.value = false
    } catch (err) {
        error.value = 'Failed to submit. Try again later.'
    } finally {
        loading.value = false
    }
}
</script>