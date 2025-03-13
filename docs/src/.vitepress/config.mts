// We can use mergeConfig method from vite or vitest/config entries to merge Vitepress config with Vitest config:
import { mergeConfig } from 'vite';
import { defineConfig as defineViteConfig} from 'vitepress';
import { defineConfig as defineVitestConfig } from 'vitest/config';
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import navData from './navData.json';
import sidebarData from './sidebarData.json';

const nav = [
  {text: 'Home', link: '/'},
  ...navData,
  { text: 'Pkgs versions', link: '/pkgs_versions' },
]

const sidebar = {
  ...sidebarData,
}

// https://vitepress.dev/reference/site-config
const vitestConfig = defineVitestConfig({
    build: {
      chunkSizeWarningLimit:500,
      rollupOptions: {
          output:{
              manualChunks(id) {
                if (id.includes('node_modules')) {
                    return id.toString().split('node_modules/')[1].split('/')[0].toString();
                }
            }
          }
      }
    },
});
const viteConfig = defineViteConfig({
  base: 'REPLACE_ME_DOCUMENTER_VITEPRESS',
  title: "Beautiful Makie",
  description: "A gallery collection",
  lastUpdated: true,
  cleanUrls: true,
  outDir: 'REPLACE_ME_DOCUMENTER_VITEPRESS',
  markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin)
    },
    theme: {
      light: "github-light",
      dark: "github-dark"}
  },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    logo: { src: '/icon_makie.png', width: 24, height: 24 },
    search: {
      provider: 'local',
      options: {
        detailedView: true
      }
    },
    nav,
    sidebar,
    editLink: 'REPLACE_ME_DOCUMENTER_VITEPRESS',
    socialLinks: [
      { icon: 'bluesky', link: 'https://bsky.app/profile/lazarusa.bsky.social' },
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/lazaro-alonso/' },
      { icon: 'mastodon', link: 'https://mastodon.social/@LazarusAlon' },
      { icon: 'twitter', link: 'https://twitter.com/LazarusAlon' },
      { icon: 'github', link: 'https://github.com/lazarusA' },
    ],
    footer: {
      message: 'Made with <a href="https://github.com/LuxDL/DocumenterVitepress.jl" target="_blank"><strong>DocumenterVitepress.jl</strong></a> & <a href="https://fredrikekre.github.io/Literate.jl/v2/" target="_blank">Literate.jl</a> <br> Released under the MIT License. Powered by the <a href="https://julialang.org" target="_blank">Julia Programming Language.</a>',
      copyright: '© Copyright 2024 <a href="https://github.com/lazarusA" target="_blank"><strong>Lazaro Alonso</strong>'
    }
  }
})

export default mergeConfig(viteConfig, vitestConfig);