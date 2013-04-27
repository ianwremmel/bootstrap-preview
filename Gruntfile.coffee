module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-customize-bootstrap'

  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'

    copy:
      glyphicons:
        src: 'components/bootstrap/img/*.png'
        dest: 'preview/img/'
      bootstrap:
        src: 'components/bootstrap/docs/assets/js/bootstrap.min.js'
        dest: 'preview/bootstrap.js'

    less:
      development:
        files:
          'preview/css/bootstrap.css': 'build/bootstrap.less'
          # 'preview/css/bootstrap-responsive.css': 'build/responsive.less'
      production:
        options:
          yuicompress: true
        files:
          'preview/css/bootstrap.css': 'build/bootstrap.less'
          # 'preview/css/bootstrap-responsive.css': 'build/responsive.less'

    customizeBootstrap:
      development:
        options:
          components: 'components'
          src: 'src/bootstrap'
          dest: 'build'

  grunt.registerTask 'default', [
    'customizeBootstrap'
    'less:development'
    'copy:glyphicons'
    'copy:bootstrap'
  ]

  grunt.registerTask 'production', [
    'customizeBootstrap'
    'less:production'
    'copy:glyphicons'
    'copy:bootstrap'
  ]