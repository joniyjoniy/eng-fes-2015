gulp = require('gulp')
mainBowerFiles = require('main-bower-files')
$ = require('gulp-load-plugins')()

app = '.'
src = app + '/src'
config =
  input:
    slim: src + '/slim/*.slim'
    scss: src + '/scss/*.scss'
    coffee: src + '/coffee/*.coffee'
    fonts: app + '/bower_components/fontawesome/fonts/fontawesome-webfont.*'
  output:
    slim: app + '/'
    css: app + '/assets/stylesheets/'
    js: app + '/assets/javascripts/'
    fonts: app + '/assets/fonts/'

gulp.task 'slim', ->
  gulp.src(config.input.slim)
    .pipe($.slim())
    .pipe(gulp.dest(config.output.slim))

gulp.task 'scss', ->
  gulp.src(config.input.scss)
    .pipe($.sass().on('error', $.sass.logError))
    .pipe($.concat('application.min.css'))
    .pipe($.minifyCss({ keepSpecialComments: 0 }))
    .pipe(gulp.dest(config.output.css))

gulp.task 'coffee', ->
  gulp.src(config.input.coffee)
    .pipe($.coffee())
    .pipe($.concat('application.min.js'))
    .pipe($.uglify())
    .pipe(gulp.dest(config.output.js))

gulp.task 'bower_scss', ->
  gulp.src(mainBowerFiles({ filter: '**/*.scss' }))
    .pipe($.sass().on('error', $.sass.logError))
    .pipe($.concat('bower_components.min.css'))
    .pipe($.minifyCss({ keepSpecialComments: 0 }))
    .pipe(gulp.dest(config.output.css))

gulp.task 'bower_js', ->
  gulp.src(mainBowerFiles({ filter: '**/*.js' }))
    .pipe($.concat('bower_components.min.js'))
    .pipe($.uglify())
    .pipe(gulp.dest(config.output.js))

gulp.task 'bower_fonts', ->
  gulp.src(config.input.fonts)
    .pipe(gulp.dest(config.output.fonts))

gulp.task 'watch', ->
  gulp.watch(config.input.slim, ['slim'])
  gulp.watch(config.input.scss, ['scss'])
  gulp.watch(config.input.coffee, ['coffee'])

gulp.task 'webserver', ->
  gulp.src(app)
    .pipe($.webserver({ host: '0.0.0.0' }))

gulp.task 'default', [
  'slim',
  'scss',
  'coffee',
  'bower_scss',
  'bower_js',
  'bower_fonts'
]

gulp.task 'development', [
  'webserver',
  'watch'
]
