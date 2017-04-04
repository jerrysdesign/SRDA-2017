var fs              = require('fs');
var cfg             = JSON.parse(fs.readFileSync('./config.json'));
var gulp            = require('gulp');
var mainBowerFiles  = require('main-bower-files');
var flatten         = require('gulp-flatten');
var changed         = require('gulp-changed');
var uglify          = require('gulp-uglify');

gulp.task('moveBower', function(){
  var files = mainBowerFiles({
    base: '../bower_components',
    debugging: true,
    overrides: {
      'jquery': { main: 'dist/jquery.min.js' },
      'jquery-ui': { main: 'jquery-ui.min.js' },
      'require': { main: 'require.js' },
      'bootstrap-sass': { main: 'assets/javascripts/bootstrap.min.js' }
    }
  });

  files.push('./src/modernizr/*.js');

  return gulp.src(files)
    .pipe(flatten())
    .pipe(gulp.dest(cfg.scripts.build_lib));
});
