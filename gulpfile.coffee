config = require('./config').config

gulp = require 'gulp'
uglify = require 'gulp-uglify'
imagemin = require 'gulp-imagemin'
nodemon = require 'gulp-nodemon'
exec = require 'gulp-exec'
coffee = require 'gulp-coffee'

paths =
  coffeescripts: ['assets/coffeescripts/**/*.coffee', '!assets/vendor/**/*.js']
  images: 'assets/images/**/*.{png,jpg,jpeg,gif}'

gulp.task 'scripts', ->
  return gulp.src(paths.coffeescripts)
    .pipe(coffee())
    .pipe(uglify())
    .pipe(gulp.dest('tmp/javascripts'));

gulp.task 'images', ->
 return gulp.src(paths.images)
    # Pass in options to the task
    .pipe imagemin({optimizationLevel: 5})
    .pipe gulp.dest('tmp/images')

gulp.task 'watch', ->
  gulp.watch paths.coffeescripts, ['scripts']
  gulp.watch paths.images, ['images']

gulp.task 'server', ->
  gulp.src('')
    .pipe(exec('supervisor app.coffee'))

gulp.task 'production', ->
  exec('pm2 start app.coffee --name #{config.appname} & coffee check.coffee')

gulp.task 'default', ['scripts', 'watch', 'server']
