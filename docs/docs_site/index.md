---
# https://vitepress.dev/reference/default-theme-home-page
layout: home
hero:
  name: "Beautiful Makie"
  tagline: Example plots
  image:
    src: /test_alpha_s.png
    alt: gfield
  actions:
    - theme: brand
      text: Sponsor
      link: https://github.com/sponsors/lazarusA?o=esb
    - theme: alt
      text: View on Github
      link: https://github.com/MakieOrg/BeautifulMakie
    - theme: alt
      text: Official Documentation
      link: https://docs.makie.org/stable/
features:
  - title: What is Makie?
    details: Makie is an interactive data visualization and plotting ecosystem for the Julia programming language, available on Windows, Linux and Mac. You can use Makie to interactively explore your data and create simple GUIs in native windows or web browsers, export high-quality vector graphics or even raytrace with physically accurate lightning.
  - title: Inspiration
    details: The name Makie (we pronounce it Mah-kee) is derived from the japanese word 蒔絵, which is a technique to sprinkle lacquer with gold and silver powder. Data is the gold and silver of our age, so let's spread it out beautifully on the screen! <br> <i>- Simon Danisch -</i>
---
<Gallery :images="images" />
<script setup lang="ts">
import Gallery from './components/Gallery.vue'
const images = [
  {
    href: 'examples/animations/scatters_size',
    src: 'examples/animations/assets/animScatters.mp4',
  },
  {
    href: 'examples/2d/lines/line_latex_bessels',
    src: 'examples/2d/lines/line_latex_bessels.svg',
  },
    {
    href: 'examples/2d/lines/line_cmaps_a',
    src: 'examples/2d/lines/line_cmaps_a.svg',
  },
    {
    href: 'examples/2d/streamplot/streamplot',
    src: 'examples/2d/streamplot/streamplot.png',
  },
    {
    href: 'examples/3d/contour3d',
    src: 'examples/3d/contour3d/contourf_contour3d.png',
  },
    {
    href: 'examples/3d/lines3d/archimedean_spiral',
    src: 'examples/3d/lines3d/archimedean_spiral.png',
  },
    {
    href: 'examples/3d/meshes/meshes',
    src: 'examples/3d/meshes/meshes.png',
  },
    {
    href: 'examples/3d/mscatters/RRGraph3D',
    src: 'examples/3d/mscatters/RRGraph3D.png',
  },
    {
    href: 'examples/themes/dark_surface_contour3d_streamplot',
    src: 'examples/themes/dark_surface_contour3d_streamplot.png',
  },
]
</script>

