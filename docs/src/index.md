```@raw html
---
# https://vitepress.dev/reference/default-theme-home-page
layout: home
hero:
  name: "Beautiful Makie"
  tagline: Example plots
  image:
    src: /test_alpha_s.png
    alt: VitePress
  actions:
    - theme: brand
      text: Sponsor
      link: /markdown-examples
    - theme: alt
      text: Short tutorial
      link: /api-examples
    - theme: alt
      text: View on Github
      link: /api-examples
    - theme: alt
      text: Official Documentation
      link: /api-examples
    - theme: alt
      text: Discourse
      link: /api-examples
    - theme: alt
      text: Packages Versions
      link: /pkgs_versions
features:
  - title: What is Makie?
    details: Makie is an interactive data visualization and plotting ecosystem for the Julia programming language, available on Windows, Linux and Mac. You can use Makie to interactively explore your data and create simple GUIs in native windows or web browsers, export high-quality vector graphics or even raytrace with physically accurate lightning.
  - title: Inspiration
    details: The name Makie (we pronounce it Mah-kee) is derived from the japanese word Maki-e, which is a technique to sprinkle lacquer with gold and silver powder. Data is the gold and silver of our age, so let's spread it out beautifully on the screen! <br> <i>- Simon Danisch -</i>
---
<Gallery :images="images" />
<script setup lang="ts">
import Gallery from './components/Gallery.vue'
const images = [
  {
    src: 'worldclim_visualization_temp_precip.mp4',
    caption: 'Library',
    desc: 'Architect Design'
  },
  {
    src: 'https://picsum.photos/350/250/?image=232',
    caption: 'Night Sky',
    desc: 'Cinematic'
  },
  {
    src: 'https://picsum.photos/350/250?image=431',
    caption: 'Tea Talk',
    desc: 'Composite'
  },
  {
    src: 'https://picsum.photos/350/250?image=474',
    caption: 'Road',
    desc: 'Landscape'
  },
  {
    src: 'https://picsum.photos/350/250?image=344',
    caption: 'Sea',
    desc: 'Cityscape'
  },
  {
    src: 'https://picsum.photos/350/250?image=494',
    caption: 'Vintage',
    desc: 'Cinematic'
  }
]
</script>
```