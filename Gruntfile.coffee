module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'

    less:
      development:
        files:
          'preview/bootstrap.css': 'src/bootstrap.less'
      production:
        options:
          yuicompress: true
        files:
          'preview/bootstrap.css': 'src/bootstrap.less'

  grunt.registerTask 'default', [
    'less:development'
  ]

  grunt.registerTask 'production', [
    'less:production'
  ]
