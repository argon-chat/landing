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
            </BlurReveal>
        </div>

    </section>
    <Transition enter-active-class="transition-opacity duration-300" enter-from-class="opacity-0"
        enter-to-class="opacity-100" leave-active-class="transition-opacity duration-300" leave-from-class="opacity-100"
        leave-to-class="opacity-0">

        <div v-if="showModal"
            class="fixed inset-0 z-[100] flex size-full items-center justify-center backdrop-blur-2xl">
            <div ref="modalRef"
                class="relative flex h-[350px] w-[600px] flex-col items-center justify-center overflow-hidden rounded-lg border bg-background md:shadow-xl">
                <div class="w-full w-full h-full rounded-lg bg-black p-6 shadow-xl">
                    <h2 class="mb-4 text-xl font-semibold text-white" style="text-align: center;">Enroll in Beta</h2>
                    <IInput v-model="email" type="email" placeholder="Enter your email" />
                    <!-- ✅ TURNSTILE CAPTCHA -->
                    <div ref="captchaRef" class="cf-turnstile mt-4" data-sitekey="0x4AAAAAAA0DPoxKcBNZt4vC"
                        data-theme="dark"></div>
                    <div v-if="error" class="mb-2 text-red-600 text-sm">{{ error }}</div>
                    <div v-if="successMessage" class="mt-4 text-green-500 text-sm text-center">
                        {{ successMessage }}
                    </div>
                    <br />
                    <div class="flex justify-center gap-2">
                        <RainbowButton @click="submitEmail" :disabled="loading">
                            {{ loading ? 'Submitting...' : 'Submit' }}
                        </RainbowButton>
                    </div>
                    <p class="mt-4 text-xs text-center text-neutral-400 max-w-sm leading-snug justify-center"
                        style="min-width: 100%;">
                        By enrolling, you consent to the storage of your email, IP address, and country for the purpose
                        of
                        participating in the beta.
                        See our
                        <a href="https://github.com/argon-chat/legal/blob/master/privacy/en.md" target="_blank"
                            class="underline hover:text-neutral-200 transition">Privacy Policy</a> for
                        more
                        details.
                    </p>
                    <br />
                </div>
                <BorderBeam :size="250" :duration="10" :delay="1" :border-width="2" />
            </div>

            <div class="absolute inset-x-0 bottom-0 z-20 h-full bg-gradient-to-t [mask-image:radial-gradient(900px_at_center,transparent_30%,white)] bg-black"
                style="z-index: -5;">
            </div>
        </div>

    </Transition>
    <footer style="    bottom: 0;position: fixed;"
        class="relative z-[2] mt-auto w-full border-t border-white/10 bg-black/40 px-6 py-6 text-center text-sm text-neutral-400 backdrop-blur">
        <div class="max-w-4xl mx-auto flex flex-col items-center gap-2 sm:flex-row sm:justify-between">
            <div class="text-xs sm:text-sm">
                © {{ new Date().getFullYear() }} Argon Inc. All rights reserved.
            </div>
            <div class="flex flex-wrap gap-4 text-xs sm:text-sm">
                <a target="_blank" href="https://github.com/argon-chat"
                    class="hover:text-neutral-200 transition-colors">Github</a>
                <a target="_blank" href="https://github.com/argon-chat/legal/blob/master/tos/en.md"
                    class="hover:text-neutral-200 transition-colors">Term Of Service</a>
                <a target="_blank" href="https://github.com/argon-chat/legal/blob/master/privacy/en.md"
                    class="hover:text-neutral-200 transition-colors">Privacy</a>
                <a target="_blank" href="https://status.argon.gl"
                    class="hover:text-neutral-200 transition-colors">System Status</a>

            </div>
        </div>
    </footer>
</template>
<script setup lang="ts">
import BlurReveal from "./BlurReveal.vue";
import BorderBeam from "./BorderBeam.vue";
import FallingStarsBg from "./FallingStarsBg.vue";
import Header from "./Header.vue";
import RainbowButton from "./RainbowButton.vue";
import IInput from "./IInput.vue";
import { ref, onMounted, onBeforeUnmount, nextTick } from 'vue'

const showModal = ref(false)
const email = ref('')
const loading = ref(false)
const success = ref(false)
const successMessage = ref('')
const error = ref('')
const modalRef = ref<HTMLElement | null>(null)
const captchaRef = ref<HTMLElement | null>(null)
let captchaToken = ''


const openModal = async () => {
    showModal.value = true
    email.value = ''
    error.value = ''
    success.value = false

    await nextTick();

    if ((window as any)["turnstile"] && captchaRef.value) {
        (window as any).turnstile.render(captchaRef.value, {
            sitekey: "0x4AAAAAAA0DPoxKcBNZt4vC",
            theme: "dark",
            callback: (token: string) => {
                captchaToken = token
            }
        })
    }
}


const closeModal = () => {
    showModal.value = false
}

const handleClickOutside = (event: MouseEvent) => {
    if (showModal.value && modalRef.value && !modalRef.value.contains(event.target as Node)) {
        closeModal()
    }
}

onMounted(() => {
    if (!document.getElementById("turnstile-script")) {
        const script = document.createElement("script")
        script.id = "turnstile-script"
        script.src = "https://challenges.cloudflare.com/turnstile/v0/api.js"
        script.async = true
        document.body.appendChild(script)
    }

    document.addEventListener('mousedown', handleClickOutside)
})

onBeforeUnmount(() => {
    document.removeEventListener('mousedown', handleClickOutside)
})

const submitEmail = async () => {
    if (!email.value || !email.value.includes('@')) {
        error.value = 'Please enter a valid email.'
        return
    }

    loading.value = true
    error.value = ''
    try {
        const res = await fetch('https://enroll.argon.gl', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email: email.value,
                turnstile: captchaToken
             })
    })

    if (res.status === 451) {
        error.value = 'Your region is not supported for enrollment.'
        return
    }

    if (!res.ok) throw new Error('Submission failed');

    success.value = true
    successMessage.value = 'Success! You’ve been added to the enroll queue. Please wait for your invitation 😊';
    setTimeout(() => {
        showModal.value = false
    }, 5000);
} catch (err) {
    error.value = 'Failed to submit. Try again later.'
} finally {
    loading.value = false
}
}


</script>