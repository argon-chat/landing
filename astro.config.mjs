// @ts-check
import { defineConfig } from 'astro/config';

import vue from '@astrojs/vue';

import tailwindcss from '@tailwindcss/vite';

import sitemap from '@astrojs/sitemap';

import cloudflare from '@astrojs/cloudflare';

// https://astro.build/config
export default defineConfig({
  site: "https://argon.gl",
  integrations: [vue(), sitemap()],

  vite: {
    plugins: [tailwindcss()]
  },

  adapter: cloudflare()
});