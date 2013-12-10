module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    coffeelint:
      options:
        max_line_length:
          value: 120
          level: "warn"
        no_trailing_whitespace:
          level: "warn"
      app: ['assets/coffeescripts/**/*.coffee']
    coffee:
      dev:
        expand: true
        cwd: 'assets/coffeescripts'
        src: ['**/*.coffee']
        dest: 'tmp/javascripts'
        ext: '.js'
    watch:
      options:
        livereload: false
      coffee:
        files: 'assets/coffeescripts/**/*.coffee'
        tasks: ['coffee:dev']
      js:
        files: 'assets/javascripts/**/*.coffee'
        tasks: ['copy:js']
      #images:
      # files: 'assets/images/**/*'
      # tasks: ['copy:images']
      css:
        files: 'assets/stylesheets/**/*.css'
        tasks: ['copy:css']
      less:
        files: 'assets/less/**/*.less'
        tasks: ['less:dev']
    less:
      dev:
        expand: true
        cwd: 'assets/less'
        src: ['**/*.less']
        dest: 'tmp/stylesheets'
        ext: '.css'
    imagemin:
      comp:
        files: [{
          expand: true
          cwd: 'assets/images/'
          src: ['**/*.{png,jpg,jpeg,gif}']
          dest: 'tmp/images'
        }]
    copy:
      js:
        cwd: 'tmp/javascripts/'
        src: '**/*'
        dest: 'public/javascripts'
        expand: true
      css:
        cwd: 'tmp/stylesheets/'
        src: '**/*'
        dest: 'public/stylesheets'
        expand: true
      assets:
        cwd: 'assets/vendor/'
        src: '**/*'
        dest: 'public/assets'
        expand: true
      images:
        cwd: 'assets/images/'
        src: '**/*'
        dest: 'public/images'
        expand: true
    uglify:
      dev:
        files: [{
          expand: true
          cwd: 'tmp/javascripts/'
          src: ['**/*.js', '!**/*.min.js']
          dest: 'tmp/javascripts'
          ext: '.min.js'
        }]
    cssmin:
      dev:
        expand: true
        cwd: 'tmp/stylesheets/'
        src: ['*.css', '!*.min.css']
        dest: 'tmp/stylesheets/'
        ext: '.min.css'

  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['coffeelint', 'coffee:dev', 'less:dev', 'copy:js', 'copy:css', 'copy:assets', 'uglify:dev', 'cssmin:dev']
  grunt.registerTask 'imagecomp', ['imagemin:comp']
