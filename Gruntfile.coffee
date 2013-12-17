module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean:
      pre: ['public/*']
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
    uglify:
      dev:
        files: [{
          expand: true
          cwd: 'tmp/javascripts/'
          src: ['**/*.js', '!**/*.min.js']
          dest: 'tmp/javascripts'
          ext: '.js'
        }]
    cssmin:
      dev:
        expand: true
        cwd: 'tmp/stylesheets/'
        src: ['**/*.css']
        dest: 'tmp/stylesheets/'
        ext: '.css'
    copy:
      assets:
        cwd: 'assets/vendor/'
        src: '**/*'
        dest: 'public/vendor'
        expand: true
      vendor_stylesheets:
        cwd: 'assets/vendor/stylesheets'
        src: '**/*.css'
        dest: 'tmp/stylesheets'
        expand: true
      vendor_javascripts:
        cwd: 'assets/vendor/javascripts'
        src: '**/*.js'
        dest: 'tmp/javascripts'
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
        command: 'node-dev app.coffee'
      production_start:
        command: 'pm2 start app.coffee'
      production_stop:
        command: 'pm2 stop all'
      production_reload:
        comamnd: 'pm2 reload all'


  require('load-grunt-tasks')(grunt)
  grunt.loadNpmTasks 'grunt-exec'

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
    'copy:vendor_javascripts',
    'copy:vendor_stylesheets',
    'uglify:dev',
    'cssmin:dev',
    'copy:js',
    'copy:css',
    'clean:post'
  ]

  grunt.registerTask 'stop', ['exec:production_stop']
  grunt.registerTask 'restart', ['exec:production_stop', 'exec:production_start']
  grunt.registerTask 'reload', ['exec:production_reload']

  grunt.registerTask 'default', ['deploy-assets', 'exec:dev']

  grunt.registerTask 'imagecomp', ['imagemin:comp']
