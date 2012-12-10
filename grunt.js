/*global module*/

module.exports = function (grunt) {
  'use strict';

  grunt.initConfig({
    pkg: '<json:package.json>',

    // delete the dist folder
    delete: {
      reset: {
        files: ['./dist/', './staging/', './test/client/spec/*.js']
      }
    },

    // lint CoffeeScript
    coffeeLint: {
      scripts: {
        src: ['./client/js/**/*.coffee','./server/**/*.coffee','./test/**/*.coffee'],
        indentation: {
          value: 2,
          level: 'error'
        },
        no_plusplus: {
          level: 'error'
        }
      }
    },

    // compile CoffeeScript to JavaScript
    coffee: {
      dist: {
        src: './client/js/**/*.coffee',
        dest: './staging/client/js/',
        bare: true
      },
      test: {
        src: './test/client/coffee/**/*.coffee',
        dest: './test/client/spec/',
        bare: true
      }
    },

    copy: {
      staging: {
        files: {
          'staging/client/js/libs/': 'client/js/libs/**',
          'staging/client/img/': 'client/img/**',
          'staging/client/views/': 'client/views/**',
          'staging/server/': 'server/**', 
          'staging/': ['dotcloud.yml', 'package.json']
        }
      },
      dev: {
        files: {
          'dist/': 'staging/**'
        }
      },
      prod: {
        files: {
          'dist/client/js/': 'staging/client/js/scripts.min.js',
          'dist/client/js/libs/': ['staging/client/js/libs/html5shiv-printshiv.js', 'staging/client/js/libs/json2.js'],
          'dist/client/css/': 'staging/client/css/styles.min.css',
          'dist/client/img/': 'staging/client/img/*',
          'dist/client/index.html': 'staging/client/index.min.html',
          'dist/client/views/': 'staging/client/views/**',
          'dist/server/': 'staging/server/**',
          'dist/' : ['staging/dotcloud.yml', 'staging/package.json']
        }
      },
      scripts: {
        files: {
          'dist/client/js/': ['staging/client/**/*.js', 'staging/client/**/**/*.js']
        }
      },
      styles: {
        files: {
          'dist/client/': 'staging/client/**/*.css'
        }
      },
      views: {
        files: {
          'dist/client/': 'staging/client/**/*.html'
        }
      }
    },

    lint: {
      scripts: ['./client/!(libs)**/*.js']
    },

    jshint: {
      options: {
        // CoffeeScript uses null for default parameter values
        eqnull: true
      }
    },

    // compile Less to CSS
    less: {
      dist: {
        src: './client/css/bootstrap.less',
        dest: './staging/client/css/styles.css'
      }
    },

    // compile templates
    template: {
      dev: {
        src: './client/**/*.template',
        dest: './staging/client/',
        environment: 'dev'
      },
      prod: {
        src: '<config:template.dev.src>',
        dest: '<config:template.dev.dest>',
        environment: 'prod'
      }
    },

    // optimizes files managed by RequireJS
    requirejs: {
      scripts: {
        baseUrl: './staging/client/js/',
        findNestedDependencies: true,
        include: 'requireLib',
        logLevel: 0,
        mainConfigFile: './staging/client/js/main.js',
        name: 'main',
        optimize: 'uglify',
        out: './staging/client/js/scripts.min.js',
        paths: {
          requireLib: 'libs/require'
        },
        preserveLicenseComments: false
      },
      styles: {
        baseUrl: './staging/client/css/',
        cssIn: './staging/client/css/styles.css',
        logLevel: 0,
        optimizeCss: 'standard',
        out: './staging/client/css/styles.min.css'
      }
    },

    minifyHtml: {
      prod: {
        files: {
          './staging/client/index.min.html': './staging/client/index.html'
        }
      }
    },

    watch: {
      coffee: {
        files: './client/js/**/*.coffee',
        tasks: 'coffeeLint coffee lint copy:scripts reload'
      },
      less: {
        files: './client/css/**/*.less',
        tasks: 'less copy:styles reload'
      },
      template: {
        files: '<config:template.dev.src>',
        tasks: 'template:dev copy:views reload'
      },
      html: {
        files: './client/views/*.html',
        tasks: 'copy:staging:files copy:views reload'
      },
      server: {
        files: './client/index.template',
        tasks: 'template reload'
      }
    },

    reload: {
      port: 35729, // LR default
      liveReload: {}
    },

    server: {
      app: {
        src: './dist/server/app.coffee',
        port: 3005,
        watch: './dist/server/routes.coffee'
      }
    }
  });

  grunt.loadNpmTasks('grunt-hustler');
  grunt.loadNpmTasks('grunt-reload');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('server', 'Start the express app.', function() {
    grunt.log.writeln('Starting Gintellect server');
    var server = require('./dist/server/app').listen(3005);

    // grunt.log.writeln('Stopping Gintellect server');
    // server.close();

  })

  grunt.registerTask('stack', 'server reload watch');

  grunt.registerTask('unit-tests', 'run the testacular test driver on jasmine unit tests', function () {
    var done = this.async();
    require('child_process').exec('testacular start --single-run', function (err, stdout) {
      grunt.log.write(stdout);
      done(err);
    });
  });

  grunt.registerTask('e2e-tests', 'run the testacular test driver on angular e2e tests', function () {
    var done = this.async();
    require('child_process').exec('testacular start testacularE2E.conf.js --single-run', function(err, stdout) {
      grunt.log.write(stdout);
      done(err);
    });
  });


  grunt.registerTask('jasmine-tests', 'run the jasmine-node test driver', function() {
    var done = this.async();
    require('child_process').exec('jasmine-node --coffee --forceexit ./test/server', function(err, stdout) {
      grunt.log.write(stdout);
      done(err);
    });
  });

  grunt.registerTask('default', [
    'delete',
    'coffeeLint',
    'coffee',
    'lint',
    'less',
    'template:dev',
    'copy:staging',
    'copy:dev'
  ]);

  grunt.registerTask('dev', [
    'delete',
    'coffeeLint',
    'coffee',
    'lint',
    'less',
    'template:dev',
    'copy:staging',
    'copy:dev',
    'watch'
  ]);

  grunt.registerTask('prod', [
    'delete',
    'coffeeLint',
    'coffee',
    'lint',
    'less',
    'template:prod',
    'copy:staging',
    'requirejs',
    'minifyHtml',
    'copy:prod'
  ]);


  grunt.registerTask('test', [
    'default',
    'jasmine-tests',
    'unit-tests',
    'e2e-tests'
  ]);

  grunt.registerTask('run', 'server reload watch');
};
