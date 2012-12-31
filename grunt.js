/*global module*/

module.exports = function (grunt) {
  'use strict';

  grunt.initConfig({
    pkg: '<json:package.json>',

    // delete the dist folder
    delete: {
      reset: {
        files: ['./dist/', './test/client/spec/']
      },
      temp: {
        files: ['./temp/']
      }
    },

    // lint CoffeeScript
    coffeeLint: {
      scripts: {
        src: ['./client/js/*.coffee'
        , './client/js/controllers/*.coffee'
        , './client/js/directives/*.coffee'
        , './client/js/responseInterceptors/*.coffee'
        , './client/js/services/*.coffee'
        ,'./server/**/*.coffee'],
        indentation: {
          value: 2,
          level: 'error'
        },
        no_plusplus: {
          level: 'error'
        }
      },
      tests: {
        src: ['./test/client/**/*.coffee', '/test/server/**/*.coffee'],
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
      scripts: {
        files: {'./temp/client/js/': './client/js/*.coffee'},
        bare: true
      },
      controllers: {
        files: {
          './temp/client/js/controllers': './client/js/controllers/*.coffee'
        },
        bare: true
      },
      directives: {
        files: {'./temp/client/js/directives': './client/js/directives/*.coffee'},
        bare: true
      },
      responseInterceptors: {
        files: {'./temp/client/js/responseInterceptors': './client/js/responseInterceptors/*.coffee'},
        bare: true
      },
      services: {
        files: {'./temp/client/js/services': './client/js/services/*.coffee'},
        bare: true
      },
      tests: {
        files: {
          './test/client/spec/': './test/client/coffee/**/*.coffee'
        },
        bare: true
      }
    },

    // compile Less to CSS
    less: {
      styles: {
        files: {
          './temp/client/css/styles.css': './client/css/styles.less'
        }
      }
    },

    // compile templates
    template: {
      views: {
        files: {
          './temp/client/views/': './client/views/**/*.template'
        }
      },
      dev: {
        files: {
          './temp/client/index.html': './client/index.template'
        },
        environment: 'dev'
      },
      prod: {
        files: '<config:template.dev.files>',
        environment: 'prod'
      }
    },

    inlineTemplate: {
      views: {
        files: {
          './temp/client/views/views.html': './temp/client/views/**/*.html'
        },
        type: 'text/ng-template',
        trim: 'temp'
      }
    },

    copy: {
      temp: {
        files: {
          'temp/client/js/libs/': 'client/js/libs/**',
          'temp/client/img/': 'client/img/**',
          'temp/client/views/': 'client/views/**',
          'temp/client/js/libs/gint-security.js': 'client/js/components/gint-security/client/index.js',
          'temp/server/': 'server/**', 
          'temp/': ['dotcloud.yml', 'package.json', 'prebuild.sh']
        }
      },
      components: {
        files: {
          'temp/client/views/gint-security/': 'client/js/components/gint-security/client/views/*.html'
        },
        options: {
          basePath: 'views'
        }
      },
      dev: {
        files: {
          'dist/': 'temp/**'
        }
      },
      prod: {
        files: {
          'dist/client/js/': 'temp/client/js/scripts.min.js',
          'dist/client/js/libs/': ['temp/client/js/libs/html5shiv-printshiv.js', 'temp/client/js/libs/json2.js'],
          'dist/client/css/': 'temp/client/css/styles.min.css',
          'dist/client/img/': 'temp/client/img/*',
          'dist/client/index.html': 'temp/client/index.min.html',
          'dist/client/views/': 'temp/client/views/**',
          'dist/server/': 'temp/server/**',
          'dist/' : ['temp/dotcloud.yml', 'temp/package.json', 'temp/prebuild.sh']
        }
      },
      scripts: {
        files: {
          'dist/client/js/': 'temp/client/js/**'
        }
      },
      styles: {
        files: {
          'dist/client/css/': 'temp/client/css/**'
        }
      },
      index: {
        files: {
          'dist/client/': 'temp/client/index.html'
        }
      },
      views: {
        files: {
          'dist/client/views/': 'temp/client/**/*.html'
        }
      }
    },

    // optimizes files managed by RequireJS
    requirejs: {
      scripts: {
        baseUrl: './temp/client/js/',
        findNestedDependencies: true,
        logLevel: 0,
        mainConfigFile: './temp/client/js/main.js',
        name: 'main',
        onBuildWrite: function (moduleName, path, contents) {
          var modulesToExclude = ['main'],
            shouldExcludeModule = modulesToExclude.indexOf(moduleName) >= 0;

          if (shouldExcludeModule) {
            return '';
          }

          return contents;
        },
        optimize: 'uglify',
        out: './temp/client/js/scripts.min.js',
        preserveLicenseComments: false,
        skipModuleInsertion: true,
        uglify: {
          no_mangle: false
        }
      },
      styles: {
        baseUrl: './temp/client/css/',
        cssIn: './temp/client/css/styles.css',
        logLevel: 0,
        optimizeCss: 'standard',
        out: './temp/client/css/styles.min.css'
      }
    },

    minifyHtml: {
      prod: {
        files: {
          './temp/client/index.min.html': './temp/client/index.html'
        }
      }
    },

    watch: {
      coffee: {
        files: ['./client/js/*.coffee', './client/js/!(components)/*.coffee'],
        tasks: 'coffeeLint coffee copy:scripts reload'
      },
      less: {
        files: './client/css/**/*.less',
        tasks: 'less copy:styles reload'
      },
      html: {
        files: './client/views/*.html',
        tasks: 'copy:temp:files copy:views reload'
      },
      server: {
        files: './client/index.template',
        tasks: 'template:dev copy:index reload'
      }
    },

    reload: {
      port: 35729, // LR default
      liveReload: {}
    },

  });

  grunt.loadNpmTasks('grunt-hustler');
  grunt.loadNpmTasks('grunt-reload');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('server', 'Start the express app.', function() {
    grunt.log.writeln('Starting Gintellect server');
    var server = require('./dist/server/app').listen(3005);
  })

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
    'less',
    'template:views',
    'template:dev',
    'copy:temp',
    'copy:components',
    'copy:dev',
    'delete:temp'
  ]);
  
  grunt.registerTask('run', 'default server reload watch');
  grunt.registerTask('runprod', 'prod server reload watch');

  grunt.registerTask('prod', [
    'delete',
    'coffeeLint',
    'coffee',
    'less',
    'template:views',
    'inlineTemplate',
    'template:prod',
    'copy:temp',
    'copy:components',
    'requirejs',
    'minifyHtml',
    'copy:prod',
    'delete:temp'
  ]);

  grunt.registerTask('test', [
    'default',
    'jasmine-tests',
    'unit-tests',
    'e2e-tests'
  ]);

};