config = require('./config').config

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean:
      pre: ['public/*', '!public/favicon.ico']
      post: ['tmp/*']
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
        tasks: ['coffee:dev', 'copy:js', 'clean:post']
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
        tasks: ['less:dev', 'copy:css', 'clean:post']
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
    uglify:
      js:
        files: [{
          expand: true
          cwd: 'tmp/javascripts/'
          src: ['**/*.js', '!**/*.min.js']
          dest: 'tmp/javascripts'
          ext: '.min.js'
        }]
      vendor_js:
        files: [{
          expand: true
          cwd: 'assets/vendor/javascripts/'
          src: ['**/*.js', '!**/*.min.js']
          dest: 'public/vendor/javascripts'
          ext: '.min.js'
        }]
    cssmin:
      css:
        expand: true
        cwd: 'tmp/stylesheets/'
        src: ['**/*.css', '!**/*.min.css']
        dest: 'tmp/stylesheets/'
        ext: '.min.css'
      vendor_css:
        expand: true
        cwd: 'assets/vendor/stylesheets/'
        src: ['**/*.css', '!**/*.min.css']
        dest: 'public/vendor/stylesheets/'
        ext: '.min.css'
    copy:
      assets:
        cwd: 'assets/vendor/'
        src: '**/*'
        dest: 'public/vendor'
        expand: true
      js:
        cwd: 'tmp/javascripts/'
        src: '**/*.js'
        dest: 'public/javascripts'
        expand: true
      css:
        cwd: 'tmp/stylesheets/'
        src: '**/*.css'
        dest: 'public/stylesheets'
        expand: true
      images:
        cwd: 'assets/images/'
        src: '**/*'
        dest: 'public/images'
        expand: true
    exec:
      dev:
        options:
          stdout: true
          stderr: true
        command: 'npm start'
      production_start:
        command: "NODE_ENV=production npm start"


  require('load-grunt-tasks')(grunt)
  grunt.loadNpmTasks 'grunt-exec'

  grunt.registerTask 'default', [
    'deploy-assets',
    'exec:dev'
  ]

  grunt.registerTask 'production', [
    'deploy-assets',
    'exec:production_start'
  ]

  grunt.registerTask 'deploy-assets', [
    'clean:pre',
    'coffeelint',

    'coffee:dev',
    'less:dev',
    'copy:assets',

    'uglify:js',
    'copy:js',
    'uglify:vendor_js',

    'cssmin:css',
    'copy:css',
    'cssmin:vendor_css',

    'clean:post'
  ]

  grunt.registerTask 'imagecomp', ['imagemin:comp']
