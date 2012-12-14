// Testacular configuration


// base path, that will be used to resolve files and exclude
basePath = '';


// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,
  REQUIRE,
  REQUIRE_ADAPTER,
  {pattern: 'dist/client/js/controllers/*.js', included: false},
  {pattern: 'dist/client/js/services/*.js', included: false},
  {pattern: 'dist/client/js/libs/angular.js', included: false},
  {pattern: 'dist/client/js/libs/angular-resource.js', included: false},
  {pattern: 'dist/client/js/*.js', included: false},
  {pattern: 'test/libs/*.js', included: false},

  'test/client/spec/main.js',

  {pattern: 'test/client/spec/controllers/*.js', included: false},
  {pattern: 'test/client/spec/services/*.js', included: false}
];


// list of files to exclude
exclude = [
  
];


// test results reporter to use
// possible values: dots || progress
reporter = 'progress';


// web server port
port = 8080;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari
// - PhantomJS
browsers = ['Chrome'];


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = true;
