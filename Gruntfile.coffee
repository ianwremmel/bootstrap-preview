module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'

    concat:
      development:
        src: [
          'components/bootstrap/js/bootstrap-transition.js'
          'components/bootstrap/js/bootstrap-alert.js'
          'components/bootstrap/js/bootstrap-button.js'
          'components/bootstrap/js/bootstrap-carousel.js'
          'components/bootstrap/js/bootstrap-collapse.js'
          'components/bootstrap/js/bootstrap-dropdown.js'
          'components/bootstrap/js/bootstrap-modal.js'
          'components/bootstrap/js/bootstrap-tooltip.js'
          'components/bootstrap/js/bootstrap-popover.js'
          'components/bootstrap/js/bootstrap-scrollspy.js'
          'components/bootstrap/js/bootstrap-tab.js'
          'components/bootstrap/js/bootstrap-typeahead.js'
          'components/bootstrap/js/bootstrap-affix.js'
        ]
        dest: 'preview/bootstrap.js'

    copy:
      glyphicons:
        src: 'components/bootstrap/img/*.png'
        dest: 'preview/img/'

    less:
      development:
        files:
          'preview/css/bootstrap.css': 'build/bootstrap.less'
          'preview/css/bootstrap-responsive.css': 'build/responsive.less'
      production:
        options:
          yuicompress: true
        files:
          'preview/css/bootstrap.css': 'build/bootstrap.less'
          'preview/css/bootstrap-responsive.css': 'build/responsive.less'

    buildBootstrapDotLess:
      bootstrap: {}
      responsive: {}

  grunt.registerMultiTask 'buildBootstrapDotLess', (filename)->
    fs = require 'fs'
    _ = require 'lodash'

    files = fs.readdirSync 'src'
    less = fs.readFileSync 'components/bootstrap/less/' + filename + '.less', 'utf-8'

    # First set the paths to the overrides
    _(files).each (file) ->
      less = less.replace file, '../src/' + file

    # Then set the paths to the originals
    pattern = /@import "([^.][\w\.\-_]*?)";/g # We make sure we only match items inside quotes that do not start witha leading .
    less = less.replace(pattern, '@import "../components/bootstrap/less/$1";')

    # Finally, write the new manifest to the build directory
    fs.mkdirSync 'build' unless fs.existsSync 'build'
    fs.writeFileSync 'build/' + filename + '.less', less

  grunt.registerTask 'default', [
    'concat:development'
    'buildBootstrapDotLess'
    'less:development'
    'copy:glyphicons'
  ]

  grunt.registerTask 'production', [
    'less:production'
  ]
