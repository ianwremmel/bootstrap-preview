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
          'preview/css/bootstrap.css': 'src/bootstrap.less'
          'preview/css/bootstrap-responsive.css': 'src/responsive.less'
      production:
        options:
          yuicompress: true
        files:
          'preview/css/bootstrap.css': 'src/bootstrap.less'
          'preview/css/bootstrap-responsive.css': 'src/responsive.less'

  grunt.registerTask 'default', [
    'concat:development'
    'less:development'
    'copy:glyphicons'
  ]

  grunt.registerTask 'production', [
    'less:production'
  ]
