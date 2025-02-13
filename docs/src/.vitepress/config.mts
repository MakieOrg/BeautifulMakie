// We can use mergeConfig method from vite or vitest/config entries to merge Vitepress config with Vitest config:
import { mergeConfig } from 'vite';
import { defineConfig as defineViteConfig} from 'vitepress';
import { defineConfig as defineVitestConfig } from 'vitest/config';
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'

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
    nav: [
      { text: 'Home', link: '/' },
      { text: '2D',
        items: [
          { text: 'arrows',link: '/examples/2d/arrows/arrows' },
          { text: 'band',link: '/examples/2d/band/band' },
          { text: 'bars',link: '/examples/2d/bars/stripped_bars' },
          { text: 'boxplots',link: '/examples/2d/boxplots/airquality' },
          { text: 'contour',link: '/examples/2d/contour/complex_function' },
          { text: 'density',link: '/examples/2d/density/density' },
          { text: 'errorbars',link: '/examples/2d/errorbars/errorbars' },
          { text: 'heatmaps',link: '/examples/2d/heatmaps/heatmap' },
          { text: 'histogram',link: '/examples/2d/histogram/hist' },
          { text: 'lines',link: '/examples/2d/lines/line_cmap' },
          { text: 'linesegments',link: '/examples/2d/linesegments/linesegments' },
          { text: 'poly',link: '/examples/2d/poly/poly_ngon' },
          { text: 'scatterlines',link: '/examples/2d/scatterlines/markers' },
          { text: 'scatters',link: '/examples/2d/scatters/scatter' },
          { text: 'series',link: '/examples/2d/series/series' },
          { text: 'stairs',link: '/examples/2d/stairs/stairs' },
          { text: 'stem',link: '/examples/2d/stem/stem' },
          { text: 'streamplot',link: '/examples/2d/streamplot/streamplot' },
          { text: 'text',link: '/examples/2d/text/your_name' },
          { text: 'violins',link: '/examples/2d/violins/single' },
      ]},

      { text: '3D',
      items: [
          { text: 'contour3d',link: '/examples/3d/contour3d/contour_v' },
          { text: 'lines3d',link: '/examples/3d/lines3d/line3d' },
          { text: 'meshes',link: '/examples/3d/meshes/meshes' },
          { text: 'mesh scatters',link: '/examples/3d/mscatters/cube_mscatters' },
          { text: 'surfaces',link: '/examples/3d/surfaces/onecolor' },
          { text: 'volume',link: '/examples/3d/volume/volume' },
      ]},
      { text: 'Advanced',
        items: [
          { text: 'Themes', link: '/examples/themes/black_epicycloid' },
          { text: 'Animations', link: '/examples/animations/scatter_size' },
          { text: 'Dashboards', link: '/examples/dashboards/tesseral_spherical_harmonics' },
          { text: 'Data Visualization', link: '/examples/datavis/earthquakes' },
          { text: 'Geo', link: '/examples/geo/projections' },
          { text: 'Algebra of Graphics', link: '/examples/aog/ablines' },
          { text: 'Raytracing', link: '' }
        ]},
        { text: 'Pkgs versions', link: '/pkgs_versions' },
    ],
    sidebar: {
      // This sidebar gets displayed when a user
      // is on `examples/2d` directory.
      '/examples/2d/': [
        {
          text: '2D',
          items: [
            {
              text: 'arrows',
              collapsed: true,
              items: [
                { text: 'arrows',link: '/examples/2d/arrows/arrows' },
              ],
            },
            {
              text: 'band',
              collapsed: true,
              items: [
                { text: 'band_confidence_error',link: '/examples/2d/band/band_confidence_error' },
                { text: 'band_ribbon',link: '/examples/2d/band/band_ribbon' },
                { text: 'band',link: '/examples/2d/band/band' },
                { text: 'filled_under_bell',link: '/examples/2d/band/filled_under_bell' },
                { text: 'filled_under',link: '/examples/2d/band/filled_under' },
              ],
            },
            {
              text: 'bars',
              collapsed: true,
              items: [
                { text: 'barplot_cmap_y_error',link: '/examples/2d/bars/barplot_cmap_y_error' },
                { text: 'barplot_y_error',link: '/examples/2d/bars/barplot_y_error' },
                { text: 'stripped_bars',link: '/examples/2d/bars/stripped_bars' },
                { text: 'x_barplot_error_y_error',link: '/examples/2d/bars/x_barplot_error_y_error' },
              ],
            },
            {
              text: 'boxplots',
              collapsed: true,
              items: [
                { text: 'boxplots',link: '/examples/2d/boxplots/airquality' },
                { text: 'boxplots_collection',link: '/examples/2d/boxplots/boxplots_collection' },
                { text: 'vertical_horizontal',link: '/examples/2d/boxplots/vertical_horizontal' },
              ],
            },
            {
              text: 'contour',
              collapsed: true,
              items: [
                { text: 'complex_function',link: '/examples/2d/contour/complex_function' },
                { text: 'contour_over_heatmap',link: '/examples/2d/contour/contour_over_heatmap' },
                { text: 'egg_shape',link: '/examples/2d/contour/egg_shape' },
                { text: 'qubit',link: '/examples/2d/contour/qubit' },
                { text: 'overlayed_functions',link: '/examples/2d/contour/overlayed_functions' },
              ],
            },
            {
              text: 'density',
              collapsed: true,
              items: [
                { text: 'density',link: '/examples/2d/density/density' },
                { text: 'mtcars_density',link: '/examples/2d/density/mtcars_density' },

              ],
            },
            {
              text: 'errorbars',
              collapsed: true,
              items: [
                { text: 'errorbars',link: '/examples/2d/errorbars/errorbars' },
                { text: 'simple_x_y',link: '/examples/2d/errorbars/simple_x_y' },
                { text: 'y_colormap',link: '/examples/2d/errorbars/y_colormap' },
              ],
            },
            {
              text: 'heatmaps',
              collapsed: true,
              items: [
                { text: 'heatmaps',link: '/examples/2d/heatmaps/heatmap' },
                { text: 'text_heatmap',link: '/examples/2d/heatmaps/text_heatmap' },
                { text: 'heatmap with 1 shared colorbar',link: '/examples/2d/heatmaps/heatmap1SharedCbar' },
                { text: 'heatmap with 2 shared colorbars',link: '/examples/2d/heatmaps/heatmap2SharedCbars' },
                { text: 'heatmap with bottom colorbar',link: '/examples/2d/heatmaps/heatmapCbarBottom' },
                { text: 'heatmap with left colorbar',link: '/examples/2d/heatmaps/heatmapCbarLeft' },
                { text: 'heatmap with top colorbar',link: '/examples/2d/heatmaps/heatmapCbarTop' },
                { text: 'heatmaps: grid',link: '/examples/2d/heatmaps/heatmapGrid' },
                { text: 'heatmap irregular steps',link: '/examples/2d/heatmaps/heatmapIrregular' },
                { text: 'heatmap irregular categories',link: '/examples/2d/heatmaps/heatmapIrregularCategories' },
                { text: 'heatmap: log scales',link: '/examples/2d/heatmaps/heatmapLogIrregular' },
                { text: 'heatmap: scales added',link: '/examples/2d/heatmaps/heatmapScaleAdd' },
                { text: 'heatmap: scale crosshair',link: '/examples/2d/heatmaps/heatmapScaleCrosshair' },
                { text: 'heatmap: scale detail',link: '/examples/2d/heatmaps/heatmapScaleDetail' },
                { text: 'heatmap: scale sections',link: '/examples/2d/heatmaps/heatmapScaleSections' },
                { text: 'heatmap: x, y positions',link: '/examples/2d/heatmaps/heatmapxyz' },
              ],
            },
            {
              text: 'histograms',
              collapsed: true,
              items: [
                { text: 'bins_counts',link: '/examples/2d/histogram/bins_counts' },
                { text: 'hist_pdf',link: '/examples/2d/histogram/hist_pdf' },
                { text: 'histogram',link: '/examples/2d/histogram/hist' },
                { text: 'hists_on_the_sides',link: '/examples/2d/histogram/hists_on_the_sides' },
                { text: 'normalizations',link: '/examples/2d/histogram/normalizations' },
                { text: 'parallel_image_hist',link: '/examples/2d/histogram/parallel_image_hist' },
              ],
            },
            {
              text: 'lines',
              collapsed: true,
              items: [
                { text: 'line_cmap',link: '/examples/2d/lines/line_cmap' },
                { text: 'line_cmaps_a',link: '/examples/2d/lines/line_cmaps_a' },
                { text: 'line_cmaps',link: '/examples/2d/lines/line_cmaps' },
                { text: 'line_colored_cbar',link: '/examples/2d/lines/line_colored_cbar' },
                { text: 'line_colored',link: '/examples/2d/lines/line_colored' },
                { text: 'line_inset_h',link: '/examples/2d/lines/line_inset_h' },
                { text: 'line_inset',link: '/examples/2d/lines/line_inset' },
                { text: 'line_latex_bessel',link: '/examples/2d/lines/line_latex_bessel' },
                { text: 'line_latex_bessels',link: '/examples/2d/lines/line_latex_bessels' },
                { text: 'line_latex',link: '/examples/2d/lines/line_latex' },
                { text: 'line_single',link: '/examples/2d/lines/line_single' },
                { text: 'line_time',link: '/examples/2d/lines/line_time' },
                { text: 'line_twin_axis',link: '/examples/2d/lines/line_twin_axis' },
                { text: 'line_two',link: '/examples/2d/lines/line_two' },
                { text: 'line_xlog',link: '/examples/2d/lines/line_xlog' },
                { text: 'line_xylog',link: '/examples/2d/lines/line_xylog' },
                { text: 'line_ylog',link: '/examples/2d/lines/line_ylog' },
                { text: 'line_broken_axis',link: '/examples/2d/lines/line_broken_axis' },
              ],
            },
            {
              text: 'linesegments',
              collapsed: true,
              items: [
                { text: 'linesegments',link: '/examples/2d/linesegments/linesegments' },
                { text: 'RRGraph',link: '/examples/2d/linesegments/RRGraph' },

              ],
            },
            {
              text: 'poly',
              collapsed: true,
              items: [
                { text: 'poly',link: '/examples/2d/poly/poly_ngon' },
              ],
            },
            {
              text: 'scatterlines',
              collapsed: true,
              items: [
                { text: 'markers',link: '/examples/2d/scatterlines/markers' },
                { text: 'scatters_line_leg_out',link: '/examples/2d/scatterlines/scatters_line_leg_out' },
                { text: 'scatters_line',link: '/examples/2d/scatterlines/scatters_line' },
                { text: 'simple',link: '/examples/2d/scatterlines/simple' },
                { text: 'spirals',link: '/examples/2d/scatterlines/spirals' },
              ],
            },
            {
              text: 'scatters',
              collapsed: true,
              items: [
                { text: 'bubble_plot_logxy',link: '/examples/2d/scatters/bubble_plot_logxy' },
                { text: 'bubble_plot',link: '/examples/2d/scatters/bubble_plot' },
                { text: 'iris_dataset',link: '/examples/2d/scatters/iris_dataset' },
                { text: 'makie_contributors',link: '/examples/2d/scatters/makie_contributors' },
                { text: 'scatter',link: '/examples/2d/scatters/scatter' },
                { text: 'scatters_colormap',link: '/examples/2d/scatters/scatters_colormap' },
                { text: 'scatters_legend',link: '/examples/2d/scatters/scatters_legend' },
              ],
            },
            {
              text: 'series',
              collapsed: true,
              items: [
                { text: 'series',link: '/examples/2d/series/series' },
              ],
            },
            {
              text: 'stairs',
              collapsed: true,
              items: [
                { text: 'stairs',link: '/examples/2d/stairs/stairs' },
              ],
            },
            {
              text: 'stem',
              collapsed: true,
              items: [
                { text: 'stem',link: '/examples/2d/stem/stem' },
              ],
            },
            {
              text: 'streamplot',
              collapsed: true,
              items: [
                { text: 'complex_polya_field',link: '/examples/2d/streamplot/complex_polya_field' },
                { text: 'field_heatmap',link: '/examples/2d/streamplot/field_heatmap' },
                { text: 'ode_solution',link: '/examples/2d/streamplot/ode_solution' },
                { text: 'poincare_vander',link: '/examples/2d/streamplot/poincare_vander' },
                { text: 'streamplot',link: '/examples/2d/streamplot/streamplot' },
              ],
            },
            {
              text: 'text',
              collapsed: true,
              items: [
                { text: 'your_name',link: '/examples/2d/text/your_name' },
              ],
            },
            {
              text: 'violins',
              collapsed: true,
              items: [
                { text: 'airquality',link: '/examples/2d/violins/airquality' },
                { text: 'collection_violins',link: '/examples/2d/violins/collection_violins' },
                { text: 'violins',link: '/examples/2d/violins/single' },
              ],
            },
          ]
        }
      ],
      // This sidebar gets displayed when a user
      // is on `/examples/3d` directory.
      '/examples/3d/': [
        {
          text: '3D',
          items: [
            {
              text: 'contour3d',
              collapsed: true,
              items: [
                { text: 'contour3d',link: '/examples/3d/contour3d/contour_v' },
                { text: 'contourf_contour3d',link: '/examples/3d/contour3d/contourf_contour3d' },
              ],
            },
            {
              text: 'lines3d',
              collapsed: true,
              items: [
                { text: 'archimedean_spiral',link: '/examples/3d/lines3d/archimedean_spiral' },
                { text: 'lines3d',link: '/examples/3d/lines3d/line3d' },
                { text: 'Filled 3d curve',link: '/examples/3d/lines3d/filled3d_curve'},
                { text: 'lines_wire_contour_3d',link: '/examples/3d/lines3d/lines_wire_contour_3d' },
                { text: 'wireframe_torus',link: '/examples/3d/lines3d/wireframe_torus' },
              ],
            },
            {
              text: 'meshes',
              collapsed: true,
              items: [
                { text: 'cpunkCube',link: '/examples/3d/meshes/cpunkCube' },
                { text: 'Earth_planes',link: '/examples/3d/meshes/Earth_planes' },
                { text: 'gfield',link: '/examples/3d/meshes/gfield' },
                { text: 'how_to_cube',link: '/examples/3d/meshes/how_to_cube' },
                { text: 'meshes',link: '/examples/3d/meshes/meshes' },
                { text: 'simplex',link: '/examples/3d/meshes/simplex' },
                { text: 'Isosurfaces',link: '/examples/3d/meshes/isosurfaces' },
              ],
            },
            {
              text: 'mesh scatters',
              collapsed: true,
              items: [
                { text: 'cube mscatters',link: '/examples/3d/mscatters/cube_mscatters' },
                { text: 'gauss2d',link: '/examples/3d/mscatters/gauss2d' },
                { text: 'RGBAcube',link: '/examples/3d/mscatters/RGBAcube' },
                { text: 'RRGraph3D',link: '/examples/3d/mscatters/RRGraph3D' },
                { text: 'SSAO_meshscatter',link: '/examples/3d/mscatters/SSAO_meshscatter' },
                { text: 'SSAO_mgrid',link: '/examples/3d/mscatters/SSAO_mgrid' },
                { text: 'LScene limits',link: '/examples/3d/mscatters/lscene_limits' },
              ],
            },
            {
              text: 'surfaces',
              collapsed: true,
              items: [
                { text: 'band3d',link: '/examples/3d/surfaces/band3d' },
                { text: 'branching',link: '/examples/3d/surfaces/branching' },
                { text: 'complex_function',link: '/examples/3d/surfaces/complex_function' },
                { text: 'constraints',link: '/examples/3d/surfaces/constraints' },
                { text: 'gabriels_horn',link: '/examples/3d/surfaces/gabriels_horn' },
                { text: 'klein_bottle',link: '/examples/3d/surfaces/klein_bottle' },
                { text: 'onecolor',link: '/examples/3d/surfaces/onecolor' },
                { text: 'revolution_surface_s',link: '/examples/3d/surfaces/revolution_surface_s' },
                { text: 'revolution_surface',link: '/examples/3d/surfaces/revolution_surface' },
                { text: 'surface_filled_sides',link: '/examples/3d/surfaces/surface_filled_sides' },
                { text: 'surface',link: '/examples/3d/surfaces/surface' },
                { text: 'tesseralSphericalH',link: '/examples/3d/surfaces/tesseralSphericalH' },
                { text: 'torus',link: '/examples/3d/surfaces/torus' },
              ],
            },
            {
              text: 'volume',
              collapsed: true,
              items: [
                { text: 'volume',link: '/examples/3d/volume/volume' },
                { text: 'volume_contour_scatters',link: '/examples/3d/volume/volume_contour_scatters' },

              ],
            },
          ],
        }
      ],
      // This sidebar gets displayed when a user
      // is on `/examples/themes/` directory.
      '/examples/themes/': [
        {
          text: 'Themes',
          collapsed: true,
          items: [
            { text: 'black: epicycloid', link: '/examples/themes/black_epicycloid' },
            { text: 'dark: surface, contour3d & streamplot', link: '/examples/themes/dark_surface_contour3d_streamplot' },
            { text: 'minimal: series', link: '/examples/themes/minimal_series' },
            { text: 'ggplot2: stem', link: '/examples/themes/ggplot2_stem' },
            { text: 'light: poly', link: '/examples/themes/light_ngon' },

          ],
        },
      ],
      // This sidebar gets displayed when a user
      // is on `/examples/themes/` directory.
      '/examples/animations/': [
        {
          text: 'Animations',
          collapsed: true,
          items: [
            { text: 'gravities', link: '/examples/animations/gravities' },
            { text: 'rotating_with_time', link: '/examples/animations/rotating_with_time' },
            { text: 'scatter_and_line', link: '/examples/animations/scatter_and_line' },
            { text: 'scatter_size', link: '/examples/animations/scatter_size' },
            { text: 'travelling_solar_system', link: '/examples/animations/travelling_solar_system' },
          ],
        },
      ],
      '/examples/dashboards/': [
        {
          text: 'dashboards',
          collapsed: true,
          items: [
            { text: 'Menu and sliders', link: '/examples/dashboards/tesseral_spherical_harmonics' },
            { text: 'slider colormaps', link: '/examples/dashboards/colorschemes' },
            { text: 'slider matcap', link: '/examples/dashboards/matcap' },
          ],
        },
      ],
      '/examples/aog/': [
        {
          text: 'AlgebraOfGraphics',
          collapsed: true,
          items: [
            { text: 'ablines', link: '/examples/aog/ablines' },
            { text: 'datasaurus', link: '/examples/aog/datasaurus' },
            { text: 'density_ridges', link: '/examples/aog/density_ridges' },
            // { text: 'gapminder', link: '/examples/aog/gapminder' },
            { text: 'MarketData', link: '/examples/aog/MarketData' },
            { text: 'penguins', link: '/examples/aog/penguins' },
            { text: 'penguins3d', link: '/examples/aog/penguins3d' },
            { text: 'penguinsAoG', link: '/examples/aog/penguinsAoG' },
            { text: 'penguinsBoxes', link: '/examples/aog/penguinsBoxes' },
            { text: 'penguinsViolins', link: '/examples/aog/penguinsViolins' },
            { text: 'scatterlinesAoG', link: '/examples/aog/scatterlinesAoG' },
            { text: 'textScatterLines', link: '/examples/aog/textScatterLines' },
          ],
        },
      ],
      '/examples/geo/': [
        {
          text: 'Geo',
          collapsed: true,
          items: [
            { text: 'blue_marble', link: '/examples/geo/blue_marble' },
            { text: 'coastlines', link: '/examples/geo/coastlines' },
            { text: 'donut_earth_sun', link: '/examples/geo/donut_earth_sun' },
            { text: 'moon', link: '/examples/geo/moon' },
            { text: 'projections', link: '/examples/geo/projections' },
            { text: 'Rasters animation', link: '/examples/geo/rasters' },
            { text: 'us_states', link: '/examples/geo/us_states' },
            { text: 'vertical_feature_mask', link: '/examples/geo/vertical_feature_mask' },
          ],
        },
      ],
      '/examples/datavis/': [
        {
          text: 'Data Visualization',
          collapsed: true,
          items: [
            { text: 'astronauts', link: '/examples/datavis/astronauts' },
            { text: 'earthquakes_proj', link: '/examples/datavis/earthquakes_proj' },
            { text: 'earthquakes', link: '/examples/datavis/earthquakes' },
            { text: 'eigenvals_densities', link: '/examples/datavis/eigenvals_densities' },
            { text: 'eigenvals_evolution', link: '/examples/datavis/eigenvals_evolution' },
            { text: 'fractals', link: '/examples/datavis/fractals' },
            { text: 'leos', link: '/examples/datavis/leos' },
            { text: 'multipleTitles', link: '/examples/datavis/multipleTitles' },
            { text: 'strange_attractors', link: '/examples/datavis/strange_attractors' },
            { text: 'candlestick', link: '/examples/datavis/candlestick' },
          ],
        },
      ],
    },
    editLink: 'REPLACE_ME_DOCUMENTER_VITEPRESS',
    socialLinks: [
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/lazaro-alonso/' },
      { icon: 'github', link: 'https://github.com/lazarusA' },
      { icon: 'mastodon', link: 'https://julialang.social/@LazaroAlonso' },
      { icon: 'twitter', link: 'https://twitter.com/LazarusAlon' }
    ],
    footer: {
      message: 'Made with <a href="https://github.com/LuxDL/DocumenterVitepress.jl" target="_blank"><strong>DocumenterVitepress.jl</strong></a> & <a href="https://fredrikekre.github.io/Literate.jl/v2/" target="_blank">Literate.jl</a> <br> Released under the MIT License. Powered by the <a href="https://julialang.org" target="_blank">Julia Programming Language.</a>',
      copyright: '© Copyright 2024 <a href="https://github.com/lazarusA" target="_blank"><strong>Lazaro Alonso</strong>'
    }
  }
})

export default mergeConfig(viteConfig, vitestConfig);