import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Beautiful Makie",
  description: "A gallery collection",
  lastUpdated: true,
  cleanUrls: true,
  
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
      provider: 'local'
    },
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Basics',
        items: [
          { text: 'Pkgs Versions', link: '/pkgs_versions' },
          { text: 'Short tutorial', link: '/markdown-examples'  },
          { text: '2D', link: '/examples/generated/scatters/scatter' },
          { text: '3D', link: '/examples/generated/scatters/scatter'},
      ]},
      { text: 'Intermediate',
        items: [
          { text: 'Themes', link: '/examples/generated/scatters/scatter' },
          { text: 'Animations', link: '/examples/generated/scatters/scatter' },
          { text: 'Dashboards', link: '/examples/generated/scatters/scatter' },
      ]},
      { text: 'Advanced',
        items: [
          { text: 'Data Visualization', link: '/examples/generated/scatters/scatter' },
          { text: 'Geo', link: '/examples/generated/scatters/scatter' },
          { text: 'Algebra of Graphics', link: '/examples/generated/scatters/scatter' },
          { text: 'Raytracing', link: '/examples/generated/scatters/scatter' }
        ]}
    ],
    sidebar: [
      {
        text: 'Scatters',
        items: [
          { text: 'scatter', link: '/examples/generated/scatters/scatter' },
          { text: 'scatter colormap', link: '/examples/generated/scatters/scatters_colormap' },
          { text: 'bubble plot', link: '/examples/generated/scatters/bubble_plot' },
          { text: 'bubble plot log xy', link: '/examples/generated/scatters/bubble_plot_logxy' },
          { text: 'iris dataset', link: '/examples/generated/scatters/iris_dataset' },
        ]
      },
      {
        text: 'Lines',
        items: [
          { text: 'single', link: '/examples/generated/lines/line_single' },
          { text: 'two', link: '/examples/generated/lines/line_two' },
          { text: 'x log', link: '/examples/generated/lines/line_xlog' },
          { text: 'y log', link: '/examples/generated/lines/line_ylog' },
          { text: 'xy log', link: '/examples/generated/lines/line_xylog' },
          { text: 'with colormap', link: '/examples/generated/lines/line_cmap' },
          { text: 'with colormaps', link: '/examples/generated/lines/line_cmaps' },
          { text: 'more colormaps', link: '/examples/generated/lines/line_cmaps_a' },
          { text: 'with colorbar', link: '/examples/generated/lines/line_colored_cbar' },
          { text: 'colorful', link: '/examples/generated/lines/line_colored' },
          { text: 'inset', link: '/examples/generated/lines/line_inset' },
          { text: 'inset h', link: '/examples/generated/lines/line_inset_h' },
          { text: 'latex', link: '/examples/generated/lines/line_latex' },
          { text: 'latex bessel', link: '/examples/generated/lines/line_latex_bessel' },
          { text: 'latex bessels', link: '/examples/generated/lines/line_latex_bessels' },
          { text: 'time', link: '/examples/generated/lines/line_time' },
          { text: 'twin axis', link: '/examples/generated/lines/line_twin_axis' }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/vuejs/vitepress' },
      { icon: 'twitter', link: 'https://twitter.com/LazarusAlon' }
    ],
    footer: {
      message: 'Made with <a href="https://vitepress.dev" target="_blank"><strong>VitePress</strong></a>, <a href="https://documenter.juliadocs.org/stable/" target="_blank">Documenter.jl</a> & <a href="https://fredrikekre.github.io/Literate.jl/v2/" target="_blank">Literate.jl</a> <br> Released under the MIT License. Powered by the <a href="https://julialang.org" target="_blank">Julia Programming Language.</a>',
      copyright: 'Copyright © 2023-present <strong>Lazaro Alonso</strong>'
    }
  }
})
