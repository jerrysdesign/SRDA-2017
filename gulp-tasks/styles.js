var fs              = require('fs');
var cfg             = JSON.parse(fs.readFileSync('./config.json'));
var gulp            = require('gulp');
var notify          = require('gulp-notify');
var plumber         = require('gulp-plumber');
var concat          = require('gulp-concat');
var sourcemaps      = require('gulp-sourcemaps');
var rename          = require('gulp-rename');
var sass            = require('gulp-sass');
var sassGlob        = require('gulp-sass-glob');


var postcss = require('gulp-postcss');
var gradientFix = require('postcss-gradient-transparency-fix');
var rucksack = require('rucksack-css');
var next = require('postcss-cssnext');
var grace = require('cssgrace');
var classPrfx = require('postcss-class-prefix');
var scopify = require('postcss-scopify');
var cssdeclsort = require('css-declaration-sorter');
var mqKeyframes = require('postcss-mq-keyframes');
var mqPacker = require('css-mqpacker');
var autoprefixer = require('autoprefixer');
var cssnano = require('cssnano');


var postcssConfigDev = [
  gradientFix,
  rucksack,
  next({browsers: cfg.browsers}),
  grace,
  classPrfx(cfg.prefix),
  scopify(cfg.scope),
  cssdeclsort({order: cfg.cssSortOrder}),
  mqKeyframes,
  mqPacker,
  autoprefixer({browsers: cfg.browsers}),
];

var postcssConfigBuild = [ 
  gradientFix,
  rucksack,
  next({browsers: cfg.browsers}),
  grace,
  classPrfx(cfg.prefix),
  scopify(cfg.scope),
  cssdeclsort({order: cfg.cssSortOrder}),
  mqKeyframes,
  mqPacker,
  autoprefixer({browsers: cfg.browsers}),
  cssnano({autoprefixer: false}),
];


// Styles Dev
gulp.task('styles', function(){
  gulp.src(cfg.styles.src)
    .pipe(sassGlob())
    .pipe(plumber({errorHandler: notify.onError(cfg.error)}))
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(postcss(postcssConfigDev))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest(cfg.styles.build));
});

// Styles Build
gulp.task('styles-build', function(){
  gulp.src(cfg.styles.src)
    .pipe(sassGlob())
    .pipe(plumber({errorHandler: notify.onError(cfg.error)}))
    .pipe(sass())
    .pipe(postcss(postcssConfigBuild))
    .pipe(rename('style.min.css'))
    .pipe(gulp.dest(cfg.styles.build));
});
