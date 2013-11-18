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
      app: ['public/coffeescripts/**/*.coffee']
    coffee:
      dev:
        expand: true
        cwd: 'public/coffeescripts'
        src: ['**/*.coffee']
        dest: 'public_built/javascripts'
        ext: '.js'
    watch:
      options:
        livereload: false
      coffee:
        files: 'public/coffeescripts/**/*.coffee'
        tasks: ['coffee:dev']
      js:
        files: 'public/javascripts/**/*.coffee'
        tasks: ['copy:js']
      #images:
      # files: 'public/images/**/*'
      # tasks: ['copy:images']
      css:
        files: 'public/stylesheets/**/*.css'
        tasks: ['copy:css']
      less:
        files: 'public/less/**/*.less'
        tasks: ['less:dev']
    less:
      dev:
        expand: true
        cwd: 'public/less'
        src: ['**/*.less']
        dest: 'public_built/stylesheets'
        ext: '.css'
    imagemin:
      comp:
        files: [{
          expand: true
          cwd: 'public/images/'
          src: ['**/*.{png,jpg,jpeg,gif}']
          dest: 'public_built/images'
        }]
    copy:
      js:
        cwd: 'public/javascripts/'
        src: '**/*'
        dest: 'public_built/javascripts'
        expand: true
      css:
        cwd: 'public/stylesheets/'
        src: '**/*'
        dest: 'public_built/stylesheets'
        expand: true
      assets:
        cwd: 'public/assets/'
        src: '**/*'
        dest: 'public_built/assets'
        expand: true
      images:
        cwd: 'public/images/'
        src: '**/*'
        dest: 'public_built/images'
        expand: true
    uglify:
      dev:
        files: [{
          expand: true
          cwd: 'public_built/javascripts'
          src: ['**/*.js', '!**/*.min.js']
          dest: 'pubilc_built/javascripts'
          ext: '.min.js'
        }]
    cssmin:
      dev:
        expand: true,
        cwd: 'public_built/stylesheets/',
        src: ['*.css', '!*.min.css'],
        dest: 'public_built/stylesheets/',
        ext: '.min.css'

  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['coffeelint', 'coffee:dev', 'less:dev', 'copy:js', 'copy:css', 'copy:assets', 'uglify:dev', 'cssmin:dev']
  grunt.registerTask 'imagecomp', ['imagemin:comp']